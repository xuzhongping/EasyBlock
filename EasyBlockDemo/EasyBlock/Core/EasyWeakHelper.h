//
//  EasyWeakHelper.h
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2018/1/21.
//  Copyright © 2018年 徐仲平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyWeakHelper : NSProxy
@property (nonatomic, weak,readonly) id target;

+ (instancetype) weakHelper:(nonnull id)target;
@end
