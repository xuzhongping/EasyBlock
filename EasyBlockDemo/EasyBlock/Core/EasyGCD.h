//
//  EasyGCD.h
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/14.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyBlockHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface EasyGCD : NSObject

/**
 easy creat a lock instance

 @return lock instance
 */
dispatch_semaphore_t easyGetLock(void);

/**
 
 @param lock lock instance
 */
void easyLock(dispatch_semaphore_t lock);

/**
 unlock
 
 @param lock lock instance
 */
void easyUnLock(dispatch_semaphore_t lock);


/**
 * warning： when you use the multipleTaskLock,
 * should set task count , and unlock count same
 * count
 */

/**
 easy creat a multiple task lock
 
 @return lock instance
 */
dispatch_semaphore_t easyGetMultipleTaskLock(void); 


/**
 lock and set lock count
 
 @param lock lock instance
 @param taskCount task count
 
 */
void easyMultipleTaskLockCount(dispatch_semaphore_t lock, int taskCount,EasyVoidBlock block);


/**
 unlock
 
 @param lock lock instance
 */
void easyMultipleTaskUnlock(dispatch_semaphore_t lock);

/**
 easy create a serial queue
 
 @param queue_name queue name
 @return queue
 */
dispatch_queue_t easyCGDGetSerialQueue(char *queue_name);
/**
 easy create a concurrent queue
 
 @param queue_name queue name
 @return queue
 */
dispatch_queue_t easyCGDGetConcurrentQueue(char *queue_name);

/**
 easy add block to async serial queue
 
 @param queue_name queue name
 @param block do something
 */
void easyGCDAsyncSerialQueue(char * _Nullable queue_name,EasyVoidBlock block);

/**
 easy add block to async concurrent queue
 
 @param queue_name queue name
 @param block do something
 */
void easyGCDAsyncConcurrentQueue(char * _Nullable queue_name,EasyVoidBlock block);

/**
 easy add block to async main queue
 
 @param block do something
 */
void easyGCDAsyncMainQueue(EasyVoidBlock block);


@end

NS_ASSUME_NONNULL_END
