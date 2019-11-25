//
//  KKFriendTableViewCell.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKFriendTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;
+ (UINib *)nib;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *invitedButton;
@property (weak, nonatomic) IBOutlet UIStackView *moreInfoStackView;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIView *separator;

#pragma mark - handler
@property (nonatomic, strong) void (^transferButtonDidTap)(void);
@property (nonatomic, strong) void (^moreInfoButtonDidTap)(void);

@end

NS_ASSUME_NONNULL_END
