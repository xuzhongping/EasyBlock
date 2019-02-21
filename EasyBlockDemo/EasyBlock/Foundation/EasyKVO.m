//
//  EasyKVO.m
//  EasyBlockDemo
//
//  Created by 徐仲平 on 2018/1/9.
//  Copyright © 2018年 徐仲平. All rights reserved.
//

#import "EasyKVO.h"
#import <objc/message.h>
#import "EasyBlockHeader.h"


@interface EasyKVO()
{
    __weak id       _target;
    BOOL            _overt;
    NSString        *_keyPath;
    EasyKVOBlock    _block;
}
@end

@implementation EasyKVO

- (void)keySEL{};
- (void)easyObserveObj:(id)obj keyPath:(NSString *)keyPath changed:(EasyKVOBlock)block{
    [self easyObserveObj:obj keyPath:keyPath changed:block overt:NO];
}
- (void)easyObserveObj:(id)obj keyPath:(NSString *)keyPath changed:(EasyKVOBlock)block overt:(BOOL)overt{
    ESParameteReturn(obj);
    ESParameteReturn(keyPath);
    ESParameteReturn(block);
    
    _target = obj;
    _overt = overt;
    _keyPath = keyPath;
    _block = block;
    objc_setAssociatedObject(obj, @selector(keySEL), self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:_keyPath] && object == _target) {
        if (_block) {
            if (object == self->_target) {
                id oldValue = change[NSKeyValueChangeOldKey];
                id newValue = change[NSKeyValueChangeNewKey];
                if (_overt) {
                    if (newValue != oldValue) {
                        _block(newValue,oldValue);
                    }
                }else{
                    _block(newValue,oldValue);
                }
            }
        }
    }
}

- (void)dealloc{
    [_target removeObserver:self forKeyPath:_keyPath];
}
@end
