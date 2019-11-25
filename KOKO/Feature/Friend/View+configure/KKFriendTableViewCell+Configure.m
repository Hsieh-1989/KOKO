//
//  KKFriendTableViewCell+Configure.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendTableViewCell+Configure.h"
#import "KKFriend.h"

@implementation KKFriendTableViewCell (Configure)

- (void)configureWithFriend:(KKFriend *)friend {
    [self.starImageView setHidden:!friend.isTop];
    self.nameLabel.text = friend.name;
    BOOL transferValid = friend.status == KKFriendStatusTransferValid;
    [self.moreInfoStackView setHidden:!transferValid];
    [self.invitedButton setHidden:transferValid];
}

@end
