//
//  UIView+EasyBlock.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/10.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "UIView+EasyBlock.h"
#import "EasyEventHandle.h"
#import <objc/message.h>
#import "EasyGCD.h"

@interface UIView ()
@property dispatch_semaphore_t  lock;
@end
@implementation UIView (EasyBlock)
static const char * property_HandlePoolKey_ = "property_HandlePoolKey";
static const char * property_lockKey_       = "property_lockKey";

- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock{
    [self addGestureRecognizer:gestureRecognizer ignoreDuration:0.0 handleBlock:handleBlock];
}
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer ignoreDuration:(CGFloat)duration handleBlock:(EasyVoidIdBlock)handleBlock{
#ifdef DEBUG
    if (!gestureRecognizer) {
        NSException *exception = [[NSException alloc] initWithName:@"warning" reason:[NSString stringWithFormat:@"the gestureRecognizer (%@) is nil",gestureRecognizer] userInfo:nil];
        @throw  exception;
    }
#else
    return;
#endif
    
    EasyEventHandle *handle = [EasyEventHandle handle];
    
    easyLock([self lock]);
    NSMutableArray *handlePool = [self getHandlePoolPropertyForInstance:gestureRecognizer];
    if (handlePool == nil || ![handlePool isKindOfClass:[NSMutableArray class]]) {
        [self setHandlePoolPropertyForInstance:gestureRecognizer];
        handlePool =[self getHandlePoolPropertyForInstance:gestureRecognizer];
    }
    easyUnLock([self lock]);
    
    [handlePool addObject:handle];
    [handle setHandBlock:handleBlock];
    [handle setSource:gestureRecognizer];
    [handle setIgnoreDuration:duration];
    [self addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer addTarget:handle action:NSSelectorFromString([NSString stringWithFormat:@"%@%ld",EasyGesturePrefix,gestureRecognizer.hash])];
}
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock{
    NSMutableArray *handlePool = [self getHandlePoolPropertyForInstance:gestureRecognizer];
    [handlePool removeAllObjects];
    [self removeGestureRecognizer:gestureRecognizer];
    if (handleBlock) {
        handleBlock(nil);
    }
}
#pragma mark - set && get

- (void)setHandlePoolPropertyForInstance:(id)instance{
    objc_setAssociatedObject(instance, property_HandlePoolKey_,@[].mutableCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)getHandlePoolPropertyForInstance:(id)instance{
    id value = objc_getAssociatedObject(instance, property_HandlePoolKey_);
    return value;
}

- (void)setSemaphoreLock:(dispatch_semaphore_t)lock{
    objc_setAssociatedObject(self, property_lockKey_,lock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (dispatch_semaphore_t)getSemaphoreLock{
    return objc_getAssociatedObject(self, property_lockKey_);
}

- (dispatch_semaphore_t)lock{
    if (![self getSemaphoreLock]) {
        [self setSemaphoreLock:easyGetLock()];
    }
    return [self getSemaphoreLock];
}
@end
