//
//  UIBarButtonItem+EasyBlock.m
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/6/15.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

#import "UIBarButtonItem+EasyBlock.h"
#import "EasyGCD.h"
#import <objc/message.h>
#import "EasyEventHandle.h"

@implementation UIBarButtonItem (EasyBlock)
static const char * property_HandlePoolKey_ = "property_HandlePoolKey";
static dispatch_semaphore_t semaphoreLock_;

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphoreLock_ = esayGetLock();
    });
}

- (void)addTouchEventHandleBlock:(EasyVoidIdBlock)block{
    
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
    [self setTarget:handle];
    [self setAction:NSSelectorFromString(EasyBarButtonAction)];
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
