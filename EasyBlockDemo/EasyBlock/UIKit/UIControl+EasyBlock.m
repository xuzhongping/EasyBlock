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

@end

@implementation UIControl (EasyBlock)
static const char * property_HandlePoolKey_ = "property_HandlePoolKey";
static dispatch_semaphore_t semaphoreLock_;

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphoreLock_ = esayGetLock();
    });
}
- (void)addEvent:(UIControlEvents)event handleBlock:(EasyVoidIdBlock)block{
    
#ifdef DEBUG
    if (event == 0) {
        NSException *exception = [[NSException alloc] initWithName:@"warning" reason:[NSString stringWithFormat:@"the event (%ld) is nil",event] userInfo:nil];
        @throw  exception;
    }
#else
    return;
#endif
    NSString *controlEventStr = [NSString stringWithFormat:@"%@%ld",EasyControlPrefix,event];
    EasyEventHandle *handle = [EasyEventHandle handle];
    
    easyLock(semaphoreLock_);
    NSMutableArray *handlePool = [self getHandlePoolProperty];
    if (handlePool == nil || ![handlePool isKindOfClass:[NSMutableArray class]]) {
        [self setHandlePoolProperty];
        handlePool =[self getHandlePoolProperty];
    }
    easyUnLock(semaphoreLock_);
    
    [handlePool addObject:handle];
    [handle setHandBlock:block];
    [handle setSource:self];
    [self addTarget:handle action:NSSelectorFromString(controlEventStr) forControlEvents:event];
}



#pragma mark - set && get

- (void)setHandlePoolProperty{
    objc_setAssociatedObject(self, property_HandlePoolKey_,@[].mutableCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)getHandlePoolProperty{
    id value = objc_getAssociatedObject(self, property_HandlePoolKey_);
    return value;
}

@end
