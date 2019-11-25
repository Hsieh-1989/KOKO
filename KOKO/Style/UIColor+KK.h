//
//  UIColor+KK.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KK)

+ (UIColor *)kkPrimaryPink;
+ (UIColor *)kkWarmGray;
+ (UIColor *)kkGreyishBrown;

@end

@interface UIColor (Friend)

+ (UIColor *)kkGreen;
+ (UIColor *)kkLightGreen;
+ (UIColor *)kkShadowGreen;
+ (UIColor *)kkSeparatorGray;
+ (UIColor *)kkContentSeparatorGray;
+ (UIColor *)kkDisabledButtonGray;
+ (UIColor *)kkTabItemGray;
+ (UIColor *)kkFriendSearchBarBackgroundGray;

@end

NS_ASSUME_NONNULL_END
