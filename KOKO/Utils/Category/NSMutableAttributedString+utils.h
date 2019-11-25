//
//  NSMutableAttributedString+utils.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (utils)

- (void)setUnderline;
- (void)setColor:(UIColor *)color;
- (void)setFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
