//
//  ViewController.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/2.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "UIKitViewController.h"
#import "UIControl+EasyBlock.h"
#import "UIView+EasyBlock.h"


@interface UIKitViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIButton *btnOne;
@property (nonatomic, strong) UISwitch *swith;
@property (nonatomic, strong) UILongPressGestureRecognizer *longG;
@end

@implementation UIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.longG = [[UILongPressGestureRecognizer alloc]init];
    [self addSubViews];
    [self defineLayouts];
    [self handleEvent];
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
    [self.swith addEvent:UIControlEventValueChanged handleBlock:^(id instanceSelf) {
        NSLog(@"%@",instanceSelf);
    }];
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

