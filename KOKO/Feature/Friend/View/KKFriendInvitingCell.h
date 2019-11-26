//
//  KKFriendInvitingCell.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKFriendInvitingCell : UITableViewCell

+ (NSString *)cellIdentifier;
+ (UINib *)nib;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *collapseView;

@end

NS_ASSUME_NONNULL_END
