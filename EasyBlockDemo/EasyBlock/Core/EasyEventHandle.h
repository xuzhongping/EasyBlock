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
@property (nonatomic, copy,readwrite) id handBlock;
@property (nonatomic,weak,readwrite)id source;

@end
