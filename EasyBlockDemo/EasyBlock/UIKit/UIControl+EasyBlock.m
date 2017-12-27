//
//  UIControl+EasyBlock.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/3.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "UIControl+EasyBlock.h"
#import <objc/message.h>
#import "EasyEventHandler.h"
#import "EasyGCD.h"


@interface UIControl ()

/**
 The array for retain handler.
 */
@property NSMutableArray         *handleCallBackPool;
@property dispatch_semaphore_t   lock;
@end

@implementation UIControl (EasyBlock)

- (void)addEvent:(UIControlEvents)event handleBlock:(EasyVoidIdBlock)block{
    [self addEVent:event ignoreDuration:0.0 handleBlock:block];
}

- (void)addEVent:(UIControlEvents)event ignoreDuration:(CGFloat)duration handleBlock:(EasyVoidIdBlock)block{
    
    ESParameteReturn(block);
    NSParameterAssert(event);
    
    NSString *controlEventStr = [NSString stringWithFormat:@"%@%ld",EasyControlPrefix,event];
    EasyEventHandler *handle = [EasyEventHandler handler];
    
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
    objc_setAssociatedObject(self, @selector(getHandlePoolProperty),@[].mutableCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)getHandlePoolProperty{
    id value = objc_getAssociatedObject(self, @selector(getHandlePoolProperty));
    return value;
}

- (void)setSemaphoreLock:(dispatch_semaphore_t)lock{
    objc_setAssociatedObject(self, @selector(getSemaphoreLock),lock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (dispatch_semaphore_t)getSemaphoreLock{
    return objc_getAssociatedObject(self, @selector(getSemaphoreLock));
}

- (dispatch_semaphore_t)lock{
    dispatch_semaphore_t lock = [self getSemaphoreLock];
    if (!lock) {
        [self setSemaphoreLock:easyGetLock()];
    }
    return lock?:[self getSemaphoreLock];
}
- (NSMutableArray *)handleCallBackPool{
    NSMutableArray *handleCallBackPool = [self getHandlePoolProperty];
    if (!handleCallBackPool) {
        [self setHandlePoolProperty];
    }
    return handleCallBackPool?:[self getHandlePoolProperty];
}

@end
