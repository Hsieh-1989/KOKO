//
//  KKFriendTableViewCell+Configure.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendTableViewCell.h"

@class KKFriend;

NS_ASSUME_NONNULL_BEGIN

@interface KKFriendTableViewCell (Configure)

- (void)configureWithFriend:(KKFriend *)friend;

@end

NS_ASSUME_NONNULL_END
