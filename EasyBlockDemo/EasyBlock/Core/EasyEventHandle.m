//
//  EasyEventHandle.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/10.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "EasyEventHandle.h"
#import "EasyEmpty.h"
#import "EasyBlockHeader.h"
#import <objc/message.h>

@interface EasyEventHandle()
@property (nonatomic, strong) NSMutableDictionary *methodBlockPool;
@end;

@implementation EasyEventHandle

+ (instancetype)handle{
    return [[self alloc]init];
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    if (aSelectorStr == nil) {
        return [EasyEmpty empty];
    }
    NSRange controlRange = [aSelectorStr rangeOfString:EasyControlPrefix];
    NSRange gestureRange = [aSelectorStr rangeOfString:EasyGesturePrefix];
    NSRange barButtonRange = [aSelectorStr rangeOfString:EasyBarButtonAction];
    if (controlRange.length >= 1) { // if the selector from UIControlEvent
        NSString *controlEventStr = [aSelectorStr substringFromIndex:controlRange.location + controlRange.length];
        NSUInteger controlEventUInteger = [controlEventStr integerValue];
        if (controlEventUInteger &  0xFFFFFFFF) {
            if (self.handBlock) {
                EasyVoidIdBlock block = self.handBlock;
                block(_source);
            }
        }
    }else if (gestureRange.length >= 1){ // if the selector from UIGestureRecognizer
        if (self.handBlock) {
            EasyVoidIdBlock block = self.handBlock;
            block(_source);
        }
    }else if (barButtonRange.length >= 1){ // if the selector from UIBarButtonItem action
        if (self.handBlock) {
            EasyVoidIdBlock block = self.handBlock;
            block(_source);
        }
    }
    
    return [EasyEmpty empty];
}


@end
