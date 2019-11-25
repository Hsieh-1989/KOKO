//
//  UIButton+KK.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "UIButton+KK.h"
#import "UIFont+KK.h"
#import "UIColor+KK.h"
#import "UIImage+utils.h"
#import "NSMutableAttributedString+utils.h"

@implementation UIButton (KK)
- (UIButton *)setPrimaryPinkStyle {
    // font
    self.titleLabel.font = [UIFont kkFontOfSize:14 weight:UIFontWeightMedium];
    // border
    self.layer.borderColor = [[UIColor kkPrimaryPink] CGColor];
    self.layer.borderWidth = 1.2;
    // normal
    [self setTitleColor:[UIColor kkPrimaryPink] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    // highlighted
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor kkPrimaryPink]] forState:UIControlStateHighlighted];
    // selected
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageFromColor:[UIColor kkPrimaryPink]] forState:UIControlStateSelected];
    
    return self;
}

- (UIButton *)setDisableStyle {
    // font
    self.titleLabel.font = [UIFont kkFontOfSize:14 weight:UIFontWeightMedium];
    // border
    self.layer.borderColor = [[UIColor kkDisabledButtonGray] CGColor];
    self.layer.borderWidth = 1.2;
    // title color
    [self setTitleColor:[UIColor kkDisabledButtonGray] forState:UIControlStateDisabled];
    
    return self;
}

- (UIButton *)setUnderlinePrimaryPinkStyleWithText:(NSString *)text {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    [attr setUnderline];
    [attr setColor:[UIColor kkPrimaryPink]];
    [attr setFont:[UIFont kkFontOfSize:14 weight:UIFontWeightRegular]];
    [self setAttributedTitle:attr forState:UIControlStateNormal];
    return self;
}

@end

@implementation GradientButton (KK)

- (void)setGreenStyleOfText:(NSString *)text icon:(UIImage *)icon {
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont kkFontOfSize:16 weight:UIFontWeightMedium];
    [self setRightIconImage:icon];
    [self setGradientFromColor:[UIColor kkGreen] toColor:[UIColor kkLightGreen]];
    self.layer.shadowColor = [[UIColor kkShadowGreen] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowRadius = 8;
    self.layer.shadowOpacity = 0.4;
}
@end
