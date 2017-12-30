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
 Creat a lock instance.
 @return lock instance
 */
dispatch_semaphore_t easyGetLock(void);

/**
 Lock up.
 @param lock instance
 */
void easyLock(dispatch_semaphore_t lock);

/**
 Unlock.
 
 @param lock instance
 */
void easyUnLock(dispatch_semaphore_t lock);


/**
 * warning： When you use a multipleTaskLock,
 * need set tasks count , and unlock count same.
 */

/**
 Creat a multiple task lock
 
 @return lock instance
 */
dispatch_semaphore_t easyGetMultipleTaskLock(void); 


/**
 Lock up and set locks count.
 
 @param lock lock instance
 @param taskCount task count
 
 */
void easyMultipleTaskLockCount(dispatch_semaphore_t lock,
                               int taskCount,
                               EasyVoidBlock block);


/**
 Unlock.
 
 @param lock lock instance
 */
void easyMultipleTaskUnlock(dispatch_semaphore_t lock);

/**
  Create a serial queue.
 
 @param queue_name queue's name
 @return queue
 */
dispatch_queue_t easyCGDGetSerialQueue(char *queue_name);
/**
 Create a concurrent queue.
 
 @param queue_name queue's name
 @return queue
 */
dispatch_queue_t easyCGDGetConcurrentQueue(char *queue_name);

/**
  Add a block to async's serial queue.
 
 @param queue_name queue's name
 @param block do something
 */
void easyGCDAsyncSerialQueue(char * _Nullable queue_name,
                             EasyVoidBlock block);

/**
  Add a block to async's concurrent queue.
 
 @param queue_name queue's name
 @param block do something
 */
void easyGCDAsyncConcurrentQueue(char * _Nullable queue_name,
                                 EasyVoidBlock block);

/**
  Add block to async's main queue.
 
 @param block do something
 */
void easyGCDAsyncMainQueue(EasyVoidBlock block);

@end

NS_ASSUME_NONNULL_END
