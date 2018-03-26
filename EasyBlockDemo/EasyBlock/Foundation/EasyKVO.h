//
//  EasyKVO.h
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2018/1/9.
//  Copyright © 2018年 徐仲平. All rights reserved.
//


#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

#define EasyObj \
\
[[EasyKVO alloc]init]

#define EasyObserver(OBJ,KEY,BLOCK) \
\
[EasyObj easyObserveObj:OBJ keyPath:@(((void)OBJ.KEY, #KEY)) changed:BLOCK]

#define EasyOvertObserver(OBJ,KEY,BLOCK) \
\
[EasyObj easyObserveObj:OBJ keyPath:@(((void)OBJ.KEY, #KEY)) changed:BLOCK overt:YES]

typedef void(^EasyKVOBlock)(id newValue,id oldValue);
@interface EasyKVO : NSObject
- (void)easyObserveObj:(id)obj keyPath:(NSString *)keyPath changed:(_Nullable EasyKVOBlock)block;
- (void)easyObserveObj:(id)obj keyPath:(NSString *)keyPath changed:(_Nullable EasyKVOBlock)block overt:(BOOL)overt;
@end





NS_ASSUME_NONNULL_END















