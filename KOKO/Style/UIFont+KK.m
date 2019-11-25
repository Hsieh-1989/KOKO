//
//  UIFont+KK.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "UIFont+KK.h"

@interface NSString (PingFang)
+ (NSString *)PingFangNameOfWeight:(UIFontWeight)weight;
@end

@implementation UIFont (KK)

+ (UIFont *)kkFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    return [UIFont PingFangFontOfSize:size weight:weight];
}

+ (UIFont *)PingFangFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    return [UIFont fontWithName:[NSString PingFangNameOfWeight:weight]
                           size:size];
}

@end

@implementation NSString (PingFang)

+ (NSString *)PingFangNameOfWeight:(UIFontWeight)weight {
    if (weight <= UIFontWeightRegular) {
        return @"PingFangTC-Regular";
    } else {
        return @"PingFangTC-Medium";
    }
}

@end
