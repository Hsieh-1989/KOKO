//
//  KKFriendListViewModel.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KKFriend;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FriendListUpdate)(void);

@interface KKFriendListViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray<KKFriend *> *validFriendList;
@property (nonatomic, strong, readonly) NSArray<KKFriend *> *invitingFriendList;

@property (nonatomic, assign) BOOL isInvitingSectionHidden;
@property (nonatomic, assign) BOOL isInvitingSectionExpand;
@property (nonatomic, strong) NSString *listInfoText;
@property (nonatomic, strong) FriendListUpdate validFriendListUpdate;
@property (nonatomic, strong) FriendListUpdate invitingFriendListUpdate;

- (instancetype)initWithValidFriendListUpdate:(FriendListUpdate)validFriendListUpdate
                     invitingFriendListUpdate:(FriendListUpdate)invitingFriendListUpdate;


- (void)reloadFriendList:(NSArray<KKFriend *> *)friendList;
- (void)searchDidStart;
- (void)searchByText:(NSString *)text;
- (void)searchDidEnd;
- (void)setInvitingListHidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
