//
//  UIBarButtonItem+EasyBlock.h
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/6/16.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"

@interface UIBarButtonItem (EasyBlock)

/**
 add touchEvent handle block
 
 @param block callback
 */
- (void)addTouchEventHandleBlock:(EasyVoidIdBlock)block;

/**
 add touchEvent handle block,can set ignore duration
 
 @param block callback
 @param duration ignore duration
 */
- (void)addTouchEventHandleBlock:(EasyVoidIdBlock)block ignoreDuration:(CGFloat)duration;
@end
