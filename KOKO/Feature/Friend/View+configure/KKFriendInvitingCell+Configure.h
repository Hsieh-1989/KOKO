//
//  KKFriendInvitingCell+Configure.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendInvitingCell.h"

@class KKFriend;

NS_ASSUME_NONNULL_BEGIN

@interface KKFriendInvitingCell (Configure)

- (void)configureWithFriend:(KKFriend *)friend isExpanded:(BOOL)isExpanded;

@end

NS_ASSUME_NONNULL_END
