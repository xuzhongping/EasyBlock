//
//  UIControl+EasyBlock.h
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/3.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIControl (EasyBlock)

/**
 Add a block for observe event.
 
 @param event event type
 @param block callback
 */
- (void)addEvent:(UIControlEvents)event handleBlock:(nullable EasyVoidIdBlock)block;

/**
 Add a block for observe event,and set ignore duration.
 
 @param event event type
 @param duration ignore duration
 @param block callback
 */
- (void)addEVent:(UIControlEvents)event ignoreDuration:(CGFloat)duration handleBlock:(nullable EasyVoidIdBlock)block;
@end

NS_ASSUME_NONNULL_END
