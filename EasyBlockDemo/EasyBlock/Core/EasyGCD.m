//
//  EasyGCD.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/14.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "EasyGCD.h"


@implementation EasyGCD

dispatch_semaphore_t easyGetLock(void){
    return dispatch_semaphore_create(1);
}

void easyLock(dispatch_semaphore_t lock){
    dispatch_wait(lock, DISPATCH_TIME_FOREVER);
}
void easyUnLock(dispatch_semaphore_t lock){
    dispatch_semaphore_signal(lock);
}



dispatch_semaphore_t easyGetMultipleTaskLock(void){
    dispatch_semaphore_t multipleTaskLock = dispatch_semaphore_create(0);
    return multipleTaskLock;
}

void easyMultipleTaskLockCount(dispatch_semaphore_t lock, int taskCount,EasyVoidBlock block){
    if (taskCount == 0) return;
    
    easyGCDAsyncConcurrentQueue(NULL, ^{
        for (int i = 0; i < taskCount; i++) {
            easyLock(lock);
        }
        easyGCDAsyncMainQueue(^{
            if (block) {
                block();
            }
        });
    });
    
}
void easyMultipleTaskUnlock(dispatch_semaphore_t lock){
    easyUnLock(lock);
}



dispatch_queue_t easyCGDGetSerialQueue(char *queue_name){
    if (queue_name == NULL || strlen(queue_name) == 0) {
        queue_name = "EasySerialQueue";
    }
    dispatch_queue_t serialQueue = dispatch_queue_create(queue_name, DISPATCH_QUEUE_SERIAL);
    return serialQueue;
}
void easyGCDAsyncSerialQueue(char *queue_name,EasyVoidBlock block){
    dispatch_queue_t serialQueue = easyCGDGetSerialQueue(queue_name);
    dispatch_async(serialQueue, ^{
        if (block) {
            block();
        }
    });
}

dispatch_queue_t easyCGDGetConcurrentQueue(char *queue_name){
    if (queue_name == NULL || strlen(queue_name) == 0) {
        queue_name = "EasyConcurrentQueue";
    }
    dispatch_queue_t concurrentQueue = dispatch_queue_create(queue_name, DISPATCH_QUEUE_CONCURRENT);
    return concurrentQueue;
}
void easyGCDAsyncConcurrentQueue(char *queue_name,EasyVoidBlock block){
    
    dispatch_queue_t concurrentQueue = easyCGDGetSerialQueue(queue_name);
    dispatch_async(concurrentQueue, ^{
        if (block) {
            block();
        }
    });
}

void easyGCDAsyncMainQueue(EasyVoidBlock block){
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        if (block) {
            block();
        }
    });
}


@end
