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
@property (nonatomic,assign,getter=isIgnore)BOOL ignore;
@end;

@implementation EasyEventHandle

+ (instancetype)handle{
    EasyEventHandle *handle = [[self alloc]init];
    [handle setIgnore:NO];
    return handle;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    if (aSelectorStr == nil) {
        return [EasyEmpty empty];
    }
    
    /*************************** handle source ********************************/
    NSRange controlRange    = [aSelectorStr rangeOfString:EasyControlPrefix];
    NSRange gestureRange    = [aSelectorStr rangeOfString:EasyGesturePrefix];
    NSRange barButtonRange  = [aSelectorStr rangeOfString:EasyBarButtonAction];
    
    EasyVoidIdBlock block = nil;
    
    if (controlRange.length >= 1) { // if the selector from UIControlEvent
        NSString *controlEventStr = [aSelectorStr substringFromIndex:controlRange.location + controlRange.length];
        NSUInteger controlEventType = [controlEventStr integerValue];
        if (controlEventType &  0xFFFFFFFF) {
            if (self.handBlock) {
                block = self.handBlock;
            }
        }
        
    }else if (gestureRange.length >= 1){ // if the selector from UIGestureRecognizer
        if (self.handBlock) {
                block = self.handBlock;
        }
        
    }else if (barButtonRange.length >= 1){ // if the selector from UIBarButtonItem action
        if (self.handBlock) {
                block = self.handBlock;
        }
    }
    /*************************************************************************/
    
   /*************************** handle ignore ********************************/
    
    if ([self isIgnore]) {
        return [EasyEmpty empty];
    }else{
        block(_source);
    }
    if (_ignoreDuration == 0.0) {
        block(_source);
        return [EasyEmpty empty];
    }
    
    [self setIgnore:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_ignoreDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setIgnore:NO];
    });
        
    /*************************************************************************/
    
    return [EasyEmpty empty];
}


@end
