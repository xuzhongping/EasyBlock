# EasyBlock
[![Version](https://img.shields.io/cocoapods/v/EasyBlock.svg?style=flat)](http://cocoapods.org/pods/EasyBlock)
[![Pod License](http://img.shields.io/cocoapods/l/EasyBlock.svg?style=flat)](https://opensource.org/licenses/MIT)
![](https://img.shields.io/badge/language-objc-orange.svg)

## 功能
1. 将所有的 UIControlEvent 事件改由 Block 处理，无需再写 target-action
2. 将所有的手势事件改由 Block 处理
3. 简易的封装了 GCD 的异步处理各种队列的接口，更简单的使用 GCD 所带来的高效率线程处理
4. 在 EasyGCD 的头文件中，增加了 dispatch_semaphore_t 所设置的锁，可以更简单的处理临界资源的互斥，具有十分优秀的性能，仅次于 OSSpinLock （自旋锁）
5. 处理开发中经常遇到的多个请求回来时再做某些操作的问题，使用一个由 dispatch_semaphore_t 封装的 EasymultipleTaskLock 来处理这种场景

## 使用方式
1. 针对于 UIKit
```
    [self.btnOne addEvent:UIControlEventTouchUpInside handleBlock:^(id instanceSelf) {
        NSLog(@"%@被点击了2",instanceSelf);
    }];
    
    [self.view addGestureRecognizer:[UITapGestureRecognizer new] handleBlock:^(id instanceSelf) {
        NSLog(@"%@",instanceSelf);
    }];
```

2. 针对 GCD 的封装api
```
	// 获得一个锁对象，上锁与解锁
	dispatch_semaphore_t lock = easyGetLock();
   easyLock(lock);
   easyUnLock(lock);
   
   // 针对多任务的 easyGetMultipleTaskLock
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
```

## 支持Cocoapods
```
	pod 'EasyBlock'
```
## 联系我
> 可以将发现的问题或有好的建议告诉我，邮箱: 1021057927@qq.com

> 可以直接在此提 Issues 与 pull

## License

PPDelegate is available under the MIT license. See the LICENSE file for more info.