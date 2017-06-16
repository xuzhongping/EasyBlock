//
//  UIBarButtonItem+EasyBlock.h
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/6/15.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"

@interface UIBarButtonItem (EasyBlock)
- (void)addTouchEventHandleBlock:(EasyVoidIdBlock)block;
@end
