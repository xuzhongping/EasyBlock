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
 这个数组是为了handle的保留
 */
@property NSMutableArray         *handleCallBackPool;
@property dispatch_semaphore_t   lock;
@end

@implementation UIControl (EasyBlock)

- (void)addEvent:(UIControlEvents)event handleBlock:(EasyVoidIdBlock)block{
    [self addEVent:event ignoreDuration:0.0 handleBlock:block];
}

- (void)addEVent:(UIControlEvents)event ignoreDuration:(CGFloat)duration handleBlock:(EasyVoidIdBlock)block{
    
    NSParameteReturn(block);
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
