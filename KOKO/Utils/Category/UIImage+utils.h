//
//  UIImage+utils.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (utils)

+ (UIImage *)imageFromColor:(UIColor *)color;
- (UIImage *)tintColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
