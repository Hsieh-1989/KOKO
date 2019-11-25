//
//  KKFriendListSectionHeaderView.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendListSectionHeaderView.h"
#import "UIFont+KK.h"
#import "UIColor+KK.h"
#import "UIImage+KK.h"

@implementation KKFriendListSectionHeaderView

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"KKFriendListSectionHeaderView" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    // label
    self.friendListLabel.font = [UIFont kkFontOfSize:13 weight:UIFontWeightMedium];
    self.friendListLabel.textColor = [UIColor kkGreyishBrown];
    // btn
    [self.addFriendButton setTitleColor:UIColor.kkPrimaryPink forState:UIControlStateNormal];
    self.addFriendButton.titleLabel.font = [UIFont kkFontOfSize:13 weight:UIFontWeightMedium];
    // searchbar
    self.searchTextField.backgroundColor = [UIColor kkFriendSearchBarBackgroundGray];
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    self.searchTextField.layer.cornerRadius = 10;
    self.searchTextField.clipsToBounds = YES;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage kkIconSearchBarSearchGray]];
    image.frame = CGRectMake(0, 0, 14, 14);
    image.center = view.center;
    [view addSubview:image];
    image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.searchTextField.leftView = view;
    self.searchTextField.placeholder = @"想轉一筆給誰呢？";
}

@end
