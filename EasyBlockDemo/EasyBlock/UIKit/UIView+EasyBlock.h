//
//  UIView+EasyBlock.h
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/10.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"

@interface UIView (EasyBlock)
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock;
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock;
@end
