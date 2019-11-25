//
//  NSMutableAttributedString+utils.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "NSMutableAttributedString+utils.h"

@implementation NSMutableAttributedString (utils)

- (void)setUnderline {
    [self addAttribute:NSUnderlineStyleAttributeName
                 value:@(NSUnderlineStyleSingle)
                 range:NSMakeRange(0, self.length)];
}

- (void)setColor:(UIColor *)color {
    [self addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:NSMakeRange(0, self.length)];
}

- (void)setFont:(UIFont *)font {
    [self addAttribute:NSFontAttributeName
                 value:font
                 range:NSMakeRange(0, self.length)];
}

@end
