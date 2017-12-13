//
//  UIView+EasyBlock.h
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/10.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIView (EasyBlock)

/**
 add Gesture handle block
 
 @param gestureRecognizer gestureRecognizer instance
 @param block callback
 */
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(nullable EasyVoidIdBlock)block;

/**
  add Gesture handle block , can set ignore duration
 
 @param gestureRecognizer gestureRecognizer instance
 @param duration ignore duration
 @param block callback
 */
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer ignoreDuration:(CGFloat)duration handleBlock:(nullable EasyVoidIdBlock)block;


/**
 remove Gesture
 
 @param gestureRecognizer gestureRecognizer instance
 @param handleBlock callback
 */
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer handleBlock:(nullable EasyVoidBlock)handleBlock;
@end

NS_ASSUME_NONNULL_END
