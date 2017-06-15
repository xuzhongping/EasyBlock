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

@implementation UIView (EasyBlock)
static const char * property_HandlePoolKey_ = "property_HandlePoolKey";
static dispatch_semaphore_t semaphoreLock_;

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphoreLock_ = esayGetLock();
    });
}
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock{
#ifdef DEBUG
    if (!gestureRecognizer) {
         NSException *exception = [[NSException alloc] initWithName:@"warning" reason:[NSString stringWithFormat:@"the gestureRecognizer (%@) is nil",gestureRecognizer] userInfo:nil];
        @throw  exception;
    }
#else
    return;
#endif
    
    EasyEventHandle *handle = [EasyEventHandle handle];
    
    easyLock(semaphoreLock_);
    NSMutableArray *handlePool = [self getHandlePoolPropertyForInstance:gestureRecognizer];
    if (handlePool == nil || ![handlePool isKindOfClass:[NSMutableArray class]]) {
        [self setHandlePoolPropertyForInstance:gestureRecognizer];
        handlePool =[self getHandlePoolPropertyForInstance:gestureRecognizer];
    }
    easyUnLock(semaphoreLock_);
    
    [handlePool addObject:handle];
    [handle setHandBlock:handleBlock];
    [handle setSource:gestureRecognizer];
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
@end
