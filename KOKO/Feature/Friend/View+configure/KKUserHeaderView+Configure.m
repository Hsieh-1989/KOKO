//
//  KKUserHeaderView+Configure.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKUserHeaderView+Configure.h"
#import "KKUser.h"

@implementation KKUserHeaderView (Configure)

- (void)configureWithUser:(KKUser *)user {
    self.nameLabel.text = user.name;
    self.idLabel.text = [NSString stringWithFormat:@"KOKO ID：%@", user.kokoid];
}

@end
