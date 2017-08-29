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

/**
 add block handle event
 
 @param event event type
 @param block callback
 */
- (void)addEvent:(UIControlEvents)event handleBlock:(EasyVoidIdBlock)block;

/**
 add block handle event,can set ignore duration
 
 @param event event type
 @param duration ignore duration
 @param block callback
 */
- (void)addEVent:(UIControlEvents)event ignoreDuration:(CGFloat)duration handleBlock:(EasyVoidIdBlock)block;
@end
