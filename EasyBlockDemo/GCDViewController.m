//
//  GCDViewController.m
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/6/16.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

#import "GCDViewController.h"
#import "EasyGCD.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)lock:(id)sender {
    NSTimeInterval beginTime,endTime = 0.0;
    beginTime = CACurrentMediaTime();
    dispatch_semaphore_t lock = easyGetLock();
    for (NSInteger i = 0; i < 9999999; i++) {
        easyLock(lock);
        easyUnLock(lock);
    }
    endTime = CACurrentMediaTime();
    NSLog(@" dispatch_semaphore_t : %f",endTime - beginTime);
}
- (IBAction)multipleTaskLock:(id)sender {
    dispatch_semaphore_t lock =  easyGetMultipleTaskLock();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), easyCGDGetConcurrentQueue(NULL), ^{
        NSLog(@"任务一完成");
        easyMultipleTaskUnlock(lock);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), easyCGDGetConcurrentQueue(NULL), ^{
        NSLog(@"任务二完成");
        easyMultipleTaskUnlock(lock);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), easyCGDGetConcurrentQueue(NULL), ^{
        NSLog(@"任务三完成");
        easyMultipleTaskUnlock(lock);
    });
    // 第二个参数输入锁的数量
    easyMultipleTaskLockCount(lock, 3, ^{
        NSLog(@"任务全部完成");
    });
}





@end
