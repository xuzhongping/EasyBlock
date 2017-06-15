//
//  EasyEmpty.m
//  EasyBlockDemo
//
//  Created by JungHsu on 2017/5/2.
//  Copyright © 2017年 JungHsu. All rights reserved.
//

#import "EasyEmpty.h"
#import <objc/message.h>

@implementation EasyEmpty
void emptyMethod(){
}
+ (instancetype)empty{
    return [[self alloc]init];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    class_addMethod(self, sel, (IMP)emptyMethod, "v@:");
    return YES;
}
@end
