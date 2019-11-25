//
//  KKFriendListViewModel.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendListViewModel.h"
#import "KKFriend.h"

@interface KKFriendListViewModel ()

@property (nonatomic, strong) NSString *searchText;

// filtered
@property (nonatomic, strong, readwrite) NSArray<KKFriend *> *validFriendList;
@property (nonatomic, strong, readwrite) NSArray<KKFriend *> *invitingFriendList;

// original
@property (nonatomic, strong) NSArray<KKFriend *> *originalValidFriendList;
@property (nonatomic, strong) NSArray<KKFriend *> *originalInvitingFriendList;

@end

@implementation KKFriendListViewModel

- (instancetype)initWithValidFriendListUpdate:(FriendListUpdate)validFriendListUpdate
                     invitingFriendListUpdate:(FriendListUpdate)invitingFriendListUpdate {
    self = [super init];
    if (self) {
        _isInvitingSectionExpand = YES;
        _isInvitingSectionHidden = NO;
        _listInfoText = @"好友列表";
        _validFriendListUpdate = validFriendListUpdate;
        _invitingFriendListUpdate = invitingFriendListUpdate;
    }
    return self;
}

#pragma mark - public method

- (void)reloadFriendList:(NSArray<KKFriend *> *)friendList {
    NSMutableArray<KKFriend *> *valid = [NSMutableArray array];
    NSMutableArray<KKFriend *> *inviting = [NSMutableArray array];
    for (KKFriend *friend in friendList) {
        if (friend.status == KKFriendStatusInvited) {
            [inviting addObject:friend];
        } else {
            [valid addObject:friend];
        }
    }
    self.originalValidFriendList = valid;
    self.originalInvitingFriendList = inviting;
}

- (void)searchDidStart {
    self.isInvitingSectionHidden = YES;
}

- (void)searchByText:(NSString *)text {
    self.searchText = text;
    [self filterValidList];
}

- (void)searchDidEnd {
    self.isInvitingSectionHidden = NO;
}

- (void)setInvitingListHidden:(BOOL)hidden {
    
}

#pragma mark - setter
- (void)setIsInvitingSectionHidden:(BOOL)isInvitingSectionHidden {
    _isInvitingSectionHidden = isInvitingSectionHidden;
    [self updateInvitingFriendList];
}

// filtered
- (void)setValidFriendList:(NSArray<KKFriend *> *)validFriendList {
    _validFriendList = validFriendList;
    if (_validFriendListUpdate) {
        _validFriendListUpdate();
    }
}

- (void)setInvitingFriendList:(NSArray<KKFriend *> *)invitingFriendList {
    _invitingFriendList = invitingFriendList;
    if (_invitingFriendListUpdate) {
        _invitingFriendListUpdate();
    }
}

// original
- (void)setOriginalValidFriendList:(NSArray<KKFriend *> *)originalValidFriendList {
    _listInfoText = [NSString stringWithFormat:@"好友列表 %ld", originalValidFriendList.count];
    _originalValidFriendList = originalValidFriendList;
    [self filterValidList];
}

- (void)setOriginalInvitingFriendList:(NSArray<KKFriend *> *)originalInvitingFriendList {
    _originalInvitingFriendList = originalInvitingFriendList;
    [self updateInvitingFriendList];
}


#pragma mark - private helper
- (void)filterValidList {
    NSString *searchText = [self.searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (searchText.length == 0) {
        self.validFriendList = self.originalValidFriendList;
        return;
    }
    self.validFriendList = [self.originalValidFriendList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        KKFriend *friend = (KKFriend *)evaluatedObject;
        return [friend.name containsString:searchText];
    }]];
}

- (void)updateInvitingFriendList {
    if (_isInvitingSectionHidden) {
        self.invitingFriendList = @[];
    } else if (_isInvitingSectionExpand) {
        self.invitingFriendList = _originalInvitingFriendList;
    } else {
        self.invitingFriendList = _originalInvitingFriendList;
    }
}

@end
