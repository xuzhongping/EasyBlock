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

/**
 add Gesture handle block
 
 @param gestureRecognizer gestureRecognizer instance
 @param handleBlock callback
 */
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock;

/**
  add Gesture handle block , can set ignore duration
 
 @param gestureRecognizer gestureRecognizer instance
 @param duration ignore duration
 @param handleBlock callback
 */
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer ignoreDuration:(CGFloat)duration handleBlock:(EasyVoidIdBlock)handleBlock;


/**
 remove Gesture
 
 @param gestureRecognizer gestureRecognizer instance
 @param handleBlock callback
 */
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(EasyVoidIdBlock)handleBlock;
@end
