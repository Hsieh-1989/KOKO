//
//  KKUserHeaderView+Configure.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//
#import "KKUserHeaderView.h"

@class KKUser;

NS_ASSUME_NONNULL_BEGIN

@interface KKUserHeaderView (Configure)

- (void)configureWithUser:(KKUser *)user;

@end

NS_ASSUME_NONNULL_END
