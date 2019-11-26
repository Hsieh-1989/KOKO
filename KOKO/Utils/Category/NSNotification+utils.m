//
//  NSNotification+utils.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/26.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "NSNotification+utils.h"

@implementation KeyboardInfo

- (instancetype)initWithAnimationCurve:(UIViewAnimationCurve)animationCurve
                     animationDuration:(NSTimeInterval)animationDuration
                               isLocal:(BOOL)isLocal
                            frameBegin:(CGRect)frameBegin
                              frameEnd:(CGRect)frameEnd {
    self = [super init];
    if (self) {
        self.animationCurve = animationCurve;
        self.animationDuration = animationDuration;
        self.isLocal = isLocal;
        self.frameBegin = frameBegin;
        self.frameEnd = frameEnd;
    }
    return self;
}

@end

@implementation NSNotification (utils)

- (KeyboardInfo *)getKeyboardInfo {
    if ([self.name isEqualToString:UIKeyboardWillShowNotification] ||
        [self.name isEqualToString:UIKeyboardDidShowNotification] ||
        [self.name isEqualToString:UIKeyboardWillHideNotification] ||
        [self.name isEqualToString:UIKeyboardDidHideNotification]) {
        
        UIViewAnimationCurve animationCurve = [self.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        NSTimeInterval animationDuration = [self.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        BOOL isLocal = [self.userInfo[UIKeyboardIsLocalUserInfoKey] boolValue];
        CGRect frameBegin = [self.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect frameEnd = [self.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        return [[KeyboardInfo alloc] initWithAnimationCurve:animationCurve
                                          animationDuration:animationDuration
                                                    isLocal:isLocal
                                                 frameBegin:frameBegin
                                                   frameEnd:frameEnd];
    }
    return nil;
}

@end
