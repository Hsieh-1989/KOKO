//
//  KKAPIClient.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKAPIRequest+KKAPI.h"

@class KKUser;
@class KKFriend;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ErrorCallback)(NSError *error);
typedef void(^RequestUserCallback)(KKUser *user);
typedef void(^RequestFriendListCallback)(NSArray<KKFriend *> *friendList);

@interface KKAPIClient : NSObject

+ (KKAPIClient *)shared;
- (instancetype)initWithSession:(NSURLSession *)session;

// default request
- (void)requestUserSuccess:(RequestUserCallback)success failure:(ErrorCallback)failure;

- (void)requestFriendListSuccess:(RequestFriendListCallback)success failure:(ErrorCallback)failure;
- (void)requestFriendListWithType:(KKFriendListType)type success:(RequestFriendListCallback)success failure:(ErrorCallback)failure;

@end

NS_ASSUME_NONNULL_END
