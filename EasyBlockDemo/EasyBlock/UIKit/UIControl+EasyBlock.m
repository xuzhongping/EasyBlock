//
//  UIControl+EasyBlock.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/3.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "UIControl+EasyBlock.h"
#import <objc/message.h>
#import "EasyEventHandle.h"
#import "EasyGCD.h"


@interface UIControl ()
@property (nonatomic,strong) dispatch_semaphore_t   lock;
@property (nonatomic,strong) NSMutableArray         *handleCallBackPool;

@end

@implementation UIControl (EasyBlock)

static const char * property_handlePoolKey_ = "property_handlePoolKey";
static const char * property_lockKey_       = "property_lockKey";

- (void)addEvent:(UIControlEvents)event handleBlock:(EasyVoidIdBlock)block{
    [self addEVent:event ignoreDuration:0.0 handleBlock:block];
}

- (void)addEVent:(UIControlEvents)event ignoreDuration:(CGFloat)duration handleBlock:(EasyVoidIdBlock)block{
    
    NSParameterAssert(event);
    
    NSString *controlEventStr = [NSString stringWithFormat:@"%@%ld",EasyControlPrefix,event];
    EasyEventHandle *handle = [EasyEventHandle handle];
    
    easyLock([self lock]);
    NSMutableArray *handlePool = [self handleCallBackPool];
    easyUnLock([self lock]);
    
    [handlePool addObject:handle];
    [handle setHandBlock:block];
    [handle setSource:self];
    [handle setIgnoreDuration:duration];
    [self addTarget:handle action:NSSelectorFromString(controlEventStr) forControlEvents:event];
}

#pragma mark - set && get

- (void)setHandlePoolProperty{
    objc_setAssociatedObject(self, property_handlePoolKey_,@[].mutableCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)getHandlePoolProperty{
    id value = objc_getAssociatedObject(self, property_handlePoolKey_);
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
- (NSMutableArray *)handleCallBackPool{
    if (![self getHandlePoolProperty]) {
        [self setHandlePoolProperty];
    }
    return [self getHandlePoolProperty];
}

@end
