//
//  KKFriend.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriend.h"

@implementation KKFriend

- (instancetype)initWithName:(NSString *)name status:(KKFriendStatus)status isTop:(BOOL)isTop fid:(NSString *)fid updateDate:(NSDate *)updateDate {
    self = [super init];
    if (self) {
        self.name = name;
        self.status = status;
        self.isTop = isTop;
        self.fid = fid;
        self.updateDate = updateDate;
    }
    return self;
}

- (NSString *)description {
    return [@[
        [NSString stringWithFormat:@"name: %@", self.name],
        [NSString stringWithFormat:@"status: %@", @(self.status)],
        [NSString stringWithFormat:@"isTop: %@", @(self.isTop)],
        [NSString stringWithFormat:@"fid: %@", self.fid],
        [NSString stringWithFormat:@"updateDate: %@", self.updateDate],
    ] componentsJoinedByString:@"\r"];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[KKFriend class]]) {
        return NO;
    }
    return [self isEqualFriend:(KKFriend *)object];
}

- (BOOL)isEqualFriend:(KKFriend *)friend {
    NSLog(@"qweqweqweqwe");
    return [self.name isEqualToString:friend.name]
    && self.status == friend.status
    && self.isTop == friend.isTop
    && [self.fid isEqualToString:friend.fid]
    && [self.updateDate isEqualToDate:friend.updateDate];
}

@end
