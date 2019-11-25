//
//  GradientButton.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientButton : UIButton

- (void)setGradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;
- (void)setRightIconImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
