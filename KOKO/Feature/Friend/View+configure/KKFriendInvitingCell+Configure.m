//
//  KKFriendInvitingCell+Configure.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendInvitingCell+Configure.h"
#import "KKFriend.h"

@implementation KKFriendInvitingCell (Configure)

- (void)configureWithFriend:(KKFriend *)friend {
    self.nameLabel.text = friend.name;
}


@end
