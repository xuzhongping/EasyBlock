//
//  UIControl+EasyBlock.h
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/3.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"

@interface UIControl (EasyBlock)

- (void)addEvent:(UIControlEvents)event handleBlock:(EasyVoidIdBlock)block;

@end
