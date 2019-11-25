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
    self.containerView.layer.masksToBounds = NO;
    self.containerView.backgroundColor = UIColor.whiteColor;
    self.containerView.layer.cornerRadius = 6;
    self.containerView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 2);
    self.containerView.layer.shadowRadius = 8;
    self.containerView.layer.shadowOpacity = 0.1;
    self.containerView.layer.shouldRasterize = YES;
    self.containerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (IBAction)acceptButtonDidTap:(id)sender {
}

- (IBAction)declineButtonDidTap:(id)sender {
}


@end
