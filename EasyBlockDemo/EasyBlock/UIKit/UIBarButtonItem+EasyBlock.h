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
 Add a block for observe touch event.
 
 @param block callback
 */
- (void)addTouchEventHandleBlock:(nullable EasyVoidIdBlock)block;

/**
 Add a block for observe touch event,and set ignore duration.
 
 @param block callback
 @param duration ignore duration
 */
- (void)addTouchEventHandleBlock:(nullable EasyVoidIdBlock)block ignoreDuration:(CGFloat)duration;
@end

NS_ASSUME_NONNULL_END
