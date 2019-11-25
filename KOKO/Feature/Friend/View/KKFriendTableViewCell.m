//
//  KKFriendTableViewCell.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendTableViewCell.h"
#import "UIColor+KK.h"
#import "UIImage+KK.h"
#import "UIFont+KK.h"
#import "UIButton+KK.h"

@implementation KKFriendTableViewCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}
+ (UINib *)nib {
    return [UINib nibWithNibName:@"KKFriendTableViewCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    // star
    self.starImageView.image = [UIImage kkIconStar];
    // avatar
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.image = [UIImage kkImgFriendsFemaleDefault];
    // namelabel
    self.nameLabel.font = [UIFont kkFontOfSize:16 weight:UIFontWeightRegular];
    // invited button
    [self.invitedButton setTitle:@"邀請已送出" forState:UIControlStateNormal];
    [self.invitedButton setDisableStyle];
    [self.invitedButton setEnabled:NO];
    [self.invitedButton setHidden:YES];
    // transfer button
    [self.transferButton setPrimaryPinkStyle];
    [self.transferButton setTitle:@"轉帳" forState:UIControlStateNormal];
    // moreInfoButton
    [self.moreButton setImage:[UIImage kkIconMoreInfo] forState:UIControlStateNormal];
    // separator
    self.separator.backgroundColor = [UIColor kkSeparatorGray];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - IBAction

- (IBAction)transferButtonDidTap:(id)sender {
    if (self.transferButtonDidTap) {
        self.transferButtonDidTap();
    }
}

- (IBAction)moreInfoButtonDidTap:(id)sender {
    if (self.moreInfoButtonDidTap) {
        self.moreInfoButtonDidTap();
    }
}


@end
