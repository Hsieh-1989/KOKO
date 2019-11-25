//
//  UIButton+KK.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KK)

- (UIButton *)setPrimaryPinkStyle;
- (UIButton *)setDisableStyle;
- (UIButton *)setUnderlinePrimaryPinkStyleWithText:(NSString *)text;

@end

@interface GradientButton (KK)

- (void)setGreenStyleOfText:(NSString *)text icon:(UIImage *)icon;

@end

NS_ASSUME_NONNULL_END
