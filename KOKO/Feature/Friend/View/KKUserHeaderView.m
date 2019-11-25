//
//  KKUserHeaderView.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKUserHeaderView.h"
#import "UIFont+KK.h"
#import "UIColor+KK.h"
#import "UIimage+KK.h"

@implementation KKUserHeaderView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2;
}

- (void)setup {
    [self loadXib];
    // name
    self.nameLabel.font = [UIFont kkFontOfSize:17 weight:UIFontWeightMedium];
    self.nameLabel.textColor = [UIColor kkGreyishBrown];
    self.nameLabel.text = @"";
    // id
    self.idLabel.font = [UIFont kkFontOfSize:13 weight:UIFontWeightRegular];
    self.idLabel.textColor = [UIColor kkGreyishBrown];
    self.idLabel.text = @"";
    // avatar
    self.avatarImageView.image = [UIImage kkImgFriendsFemaleDefault];
}

- (void)loadXib {
    UIView *content = [[[NSBundle mainBundle] loadNibNamed:@"KKUserHeaderView" owner:self options:nil] firstObject];
    [self addSubview:content];
    content.frame = self.bounds;
    [content setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    content.preservesSuperviewLayoutMargins = YES;
}

- (IBAction)idButtonDidTap:(id)sender {
}

@end
