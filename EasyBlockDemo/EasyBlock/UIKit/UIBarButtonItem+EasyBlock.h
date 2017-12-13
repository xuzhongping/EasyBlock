//
//  UIBarButtonItem+EasyBlock.h
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/6/16.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (EasyBlock)

/**
 add touchEvent handle block
 
 @param block callback
 */
- (void)addTouchEventHandleBlock:(nullable EasyVoidIdBlock)block;

/**
 add touchEvent handle block,can set ignore duration
 
 @param block callback
 @param duration ignore duration
 */
- (void)addTouchEventHandleBlock:(nullable EasyVoidIdBlock)block ignoreDuration:(CGFloat)duration;
@end

NS_ASSUME_NONNULL_END
