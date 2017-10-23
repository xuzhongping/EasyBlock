//
//  PingConfig.h
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2017/9/29.
//  Copyright © 2017年 徐仲平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingConfig : NSObject
{
    @public
    CFRunLoopActivity activity;
    dispatch_semaphore_t semaphore;
}
@end
