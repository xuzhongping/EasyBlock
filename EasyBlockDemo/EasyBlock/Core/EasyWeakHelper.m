//
//  EasyWeakHelper.m
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2018/1/21.
//  Copyright © 2018年 徐仲平. All rights reserved.
//

#import "EasyWeakHelper.h"
@interface EasyWeakHelper()
@property (nonatomic, weak,readwrite) id target;
@end
@implementation EasyWeakHelper
+ (instancetype)weakHelper:(id)target{
    EasyWeakHelper *weakHelper = [EasyWeakHelper alloc];
    weakHelper.target = target;
    return weakHelper;
}
@end
