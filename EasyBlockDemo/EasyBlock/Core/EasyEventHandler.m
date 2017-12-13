//
//  EasyEventHandle.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/6/10.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "EasyEventHandler.h"
#import "EasyEmpty.h"
#import "EasyBlockHeader.h"
#import <objc/message.h>

@interface EasyEventHandler()
@property (nonatomic,assign,getter=isIgnore)BOOL ignore;
@end;

@implementation EasyEventHandler

+ (instancetype)handler{
    EasyEventHandler *handle = [[self alloc]init];
    [handle setIgnore:NO];
    return handle;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    if (aSelectorStr == nil) {
        return [EasyEmpty empty];
    }
    
    /*************************** handle source ********************************/
    
    EasyVoidIdBlock block = nil;
    
    // if the selector from UIControlEvent
    if ([aSelectorStr containsString:EasyControlPrefix]) {
        if (self.handBlock) {
            block = self.handBlock;
        }
        
    // if the selector from UIGestureRecognizer
    }else if ([aSelectorStr containsString:EasyGesturePrefix]){
        if (self.handBlock) {
                block = self.handBlock;
        }
        
    // if the selector from UIBarButtonItem action
    }else if ([aSelectorStr containsString:EasyBarButtonPrefix]){
        if (self.handBlock) {
                block = self.handBlock;
        }
    }else{
        NSString *errorDesc = [NSString stringWithFormat:@"[%@  %@]unrecognized selector sent to instance %p",[_source class],NSStringFromSelector(aSelector),_source];
        NSAssert(false, errorDesc);
        return [EasyEmpty empty];
    }
    
    if (!block) {
        return [EasyEmpty empty];
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
