//
//  NSObject+EasyBlock.m
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/6/15.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

//#import "NSObject+EasyBlock.h"
//#import <objc/message.h>
//#import "EasyEventHandle.h"
//#import "EasyEmpty.h"
//#import "EasyGCD.h"

//@implementation NSObject (EasyBlock)
//static const char * hookBlockTableKey_;
//static dispatch_semaphore_t semaphoreLock_;
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        hookBlockTableKey_ = "hookBlockTableKey";
//        semaphoreLock_ =  easyGetLock();
//    });
//}
//- (void)easyHookInstanceMethodSelector:(SEL)selector hookType:(EASY_ASP_TYPE)type handleBlock:(EasyVoidBlock)block{
//    Method sourceMethod = class_getInstanceMethod([self class], selector);
//    Method newMethod = class_getInstanceMethod([self class], @selector(hookMethod:handleBlock:));
//    method_exchangeImplementations(sourceMethod, newMethod);
//    
//    easyLock(semaphoreLock_);
//    NSMutableDictionary *hookBlockTable = [self getHandlePoolProperty];
//    if (hookBlockTable == nil || ![hookBlockTable isKindOfClass:[NSMutableDictionary class]]) {
//        [self setHandlePoolProperty];
//        hookBlockTable =[self getHandlePoolProperty];
//    }
//    easyUnLock(semaphoreLock_);
//    NSString *key = [NSString stringWithFormat:@"%@%ld",NSStringFromSelector(selector),type];
//    [hookBlockTable setValue:block forKey:key];
//}
//- (void)hookMethod:(EASY_ASP_TYPE)type handleBlock:(EasyVoidBlock)block{
//    
//    
//    [self hookMethod:0 handleBlock:nil];
//}
//
//#pragma mark - set && get
//
//- (void)setHandlePoolProperty{
//    objc_setAssociatedObject(self, hookBlockTableKey_,@{}.mutableCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (NSMutableDictionary *)getHandlePoolProperty{
//    id value = objc_getAssociatedObject(self, hookBlockTableKey_);
//    return value;
//}

//@end

//    请忽略本文件，正在更新中

