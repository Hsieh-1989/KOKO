//
//  KKFriendListViewController.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+KK.h"

@class KKFriend;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReloadFrientList)(void);

@interface KKFriendListViewController : UIViewController<StoryboardLoadable>

@property (nonatomic, strong) NSArray<KKFriend *> *friendList;
@property (nonatomic, strong) ReloadFrientList reloadFrientList;

@end

NS_ASSUME_NONNULL_END
