//
//  UIColor+KK.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "UIColor+KK.h"

@implementation UIColor (Helper)

+ (UIColor *)r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue {
    return [UIColor r:red g:green b:blue a:1.0];
}

@end

@implementation UIColor (KK)

+ (UIColor *)kkPrimaryPink {
    return [UIColor r:236 g:0 b:140];
}

+ (UIColor *)kkWarmGray {
    return [UIColor r:153 g:153 b:153];
}

+ (UIColor *)kkGreyishBrown {
    return [UIColor r:71 g:71 b:71];
}

@end

@implementation UIColor (Friend)

+ (UIColor *)kkGreen {
    return [UIColor r:86 g:179 b:11];
}

+ (UIColor *)kkLightGreen {
    return [UIColor r:166 g:204 b:66];
}

+ (UIColor *)kkShadowGreen {
    return [UIColor r:121 g:196 b:27];
}

+ (UIColor *)kkSeparatorGray {
    return [UIColor r:228 g:228 b:228];
}

+ (UIColor *)kkContentSeparatorGray {
    return [UIColor r:239 g:239 b:239];
}

+ (UIColor *)kkDisabledButtonGray {
    return [UIColor r:201 g:201 b:201];
}

+ (UIColor *)kkTabItemGray {
    return [UIColor r:153 g:153 b:153];
}

+ (UIColor *)kkFriendSearchBarBackgroundGray {
    return [UIColor r:142 g:142 b:142 a:0.12];
}

@end
