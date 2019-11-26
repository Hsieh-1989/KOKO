//
//  KKFriendInvitingCell.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendInvitingCell.h"
#import "UIColor+KK.h"
#import "UIFont+KK.h"
#import "UIImage+KK.h"

@implementation KKFriendInvitingCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"KKFriendInvitingCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // avatar
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2;
    self.avatarImageView.image = [UIImage kkImgFriendsFemaleDefault];
    // label
    self.nameLabel.font = [UIFont kkFontOfSize:16 weight:UIFontWeightRegular];
    self.nameLabel.textColor = [UIColor kkGreyishBrown];
    self.subTextLabel.font = [UIFont kkFontOfSize:13 weight:UIFontWeightRegular];
    self.nameLabel.textColor = [UIColor kkWarmGray];
    self.subTextLabel.text = @"邀請你成為好友：）";
    // shadow
    self.contentView.layer.masksToBounds = NO;
    [self setShadow:self.containerView];
    [self setShadow:self.collapseView];
    [self.collapseView setHidden:YES];
}

- (void)setShadow:(UIView *)view {
    view.layer.masksToBounds = NO;
    view.backgroundColor = UIColor.whiteColor;
    view.layer.cornerRadius = 6;
    view.layer.shadowColor = UIColor.blackColor.CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowRadius = 8;
    view.layer.shadowOpacity = 0.1;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (IBAction)acceptButtonDidTap:(id)sender {
}

- (IBAction)declineButtonDidTap:(id)sender {
}


@end
