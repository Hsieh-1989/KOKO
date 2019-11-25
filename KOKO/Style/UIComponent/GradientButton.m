//
//  GradientButton.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "GradientButton.h"

@interface GradientButton ()

@property (nonatomic, strong) CAGradientLayer *gradient;
@property (nonatomic, strong) UIImageView *rightIcon;

@end

@implementation GradientButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // gradient
    self.gradient = [[CAGradientLayer alloc] init];
    self.gradient.startPoint = CGPointMake(0.0, 0.5);
    self.gradient.endPoint = CGPointMake(1.0, 0.5);
    [self.layer insertSublayer:self.gradient atIndex:0];
    // icon
    self.rightIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.rightIcon.userInteractionEnabled = false;
    self.rightIcon.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.rightIcon];
    [NSLayoutConstraint activateConstraints:@[
        [self.rightIcon.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.rightIcon.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-8],
        [self.rightIcon.widthAnchor constraintEqualToConstant:24],
        [self.rightIcon.heightAnchor constraintEqualToConstant:24]
    ]];
}

- (void)setGradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    self.gradient.colors = @[(id)fromColor.CGColor, (id)toColor.CGColor];
}

- (void)setRightIconImage:(UIImage *)image {
    self.rightIcon.image = image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.gradient.frame = self.bounds;
    self.gradient.cornerRadius = self.layer.cornerRadius;
}

@end
