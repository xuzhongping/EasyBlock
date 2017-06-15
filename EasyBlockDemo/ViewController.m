//
//  ViewController.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/2.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+EasyBlock.h"
#import "UIView+EasyBlock.h"
#import "EasyGCD.h"
#import "NSObject+EasyBlock.h"

@interface ViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIButton *btnOne;
@property (nonatomic, strong) UISwitch *swith;
@property (nonatomic, strong) UILongPressGestureRecognizer *longG;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.longG = [[UILongPressGestureRecognizer alloc]init];
    [self addSubViews];
    [self defineLayouts];
    [self handleEvent];
    [self testEasyGCD];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}
- (void)addSubViews{
    [self.view addSubview:self.btnOne];
    [self.view addSubview:self.swith];
}
- (void)defineLayouts{
    self.btnOne.frame = CGRectMake(100, 100, 50, 50);
    self.swith.frame = CGRectMake(100, 200, 0, 0);
}
- (void)handleEvent{
    [self.btnOne addEvent:UIControlEventTouchUpInside handleBlock:^(id instanceSelf) {
        NSLog(@"%@被点击了1",instanceSelf);
        
    }];
    [self.btnOne addEvent:UIControlEventTouchUpInside handleBlock:^(id instanceSelf) {
        NSLog(@"%@被点击了2",instanceSelf);
    }];
    
    [self.view addGestureRecognizer:[UITapGestureRecognizer new] handleBlock:^(id instanceSelf) {
        NSLog(@"%@",instanceSelf);
    }];
    [self.view addGestureRecognizer:self.longG handleBlock:^(id instanceSelf) {
        NSLog(@"%@",instanceSelf);
    }];
    
}



- (void)test:(UITapGestureRecognizer *)tap{
    NSLog(@"%@",tap);
}
- (void)testEasyGCD{
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
    easyMultipleTaskLockCount(lock, 3, ^{
          NSLog(@"任务全部完成");
    });
    
}
- (UIButton *)btnOne{
    if (!_btnOne) {
        _btnOne = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnOne setBackgroundColor:[UIColor redColor]];
        [_btnOne setTitle:@"点击" forState:UIControlStateNormal];
    }
    return _btnOne;
}

- (UISwitch *)swith{
    if (!_swith) {
        _swith = [[UISwitch alloc]init];
    }
    return _swith;
}
- (void)dealloc{
    
}
@end
