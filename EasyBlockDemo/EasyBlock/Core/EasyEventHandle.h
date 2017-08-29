//
//  EasyEventHandle.h
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/10.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyBlockHeader.h"


@interface EasyEventHandle : NSObject
+ (instancetype )handle;
@property (nonatomic,  copy) id         handBlock;
@property (nonatomic,  weak) id         source;
@property (nonatomic,assign) CGFloat    ignoreDuration;
@end
