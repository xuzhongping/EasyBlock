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
#import "UIBarButtonItem+EasyBlock.h"
#import "EasyKVO.h"

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
//    [self.btnOne addEvent:UIControlEventTouchUpInside handleBlock:^(id instanceSelf) {
//
//    }];
    [self.btnOne addEVent:UIControlEventTouchUpInside ignoreDuration:2.0 handleBlock:^(id instance) {
        NSLog(@"%@被点击了1",instance);
        [self.btnOne setFrame:CGRectMake(0, 0, 30, 30)];
    }];
    [self.view addGestureRecognizer:[UITapGestureRecognizer new] ignoreDuration:2.0 handleBlock:^(id instance) {
        NSLog(@"%@",instance);
    }];
    EasyObserver(self.btnOne,frame , ^(id new,id old){
        NSLog(@"%@-%@",new,old);
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

