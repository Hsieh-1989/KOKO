//
//  KKAPIRequest+KKAPI.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKAPIRequest.h"

typedef NS_ENUM(NSUInteger, KKFriendListType) {
    KKFriendListType1,
    KKFriendListType2,
    KKFriendListTypeFriendListWithInvitation,
    KKFriendListTypeFriendListWithoutInvitation
};

NS_ASSUME_NONNULL_BEGIN

@interface KKAPIRequest (KKAPI)

+ (KKAPIRequest<KKUser *> *)user;
+ (KKAPIRequest<NSArray<KKFriend *> *> *)friendListOfType:(KKFriendListType)type;

@end

NS_ASSUME_NONNULL_END
