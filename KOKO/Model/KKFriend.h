//
//  KKFriend.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KKFriendStatus) {
    KKFriendStatusSended = 0,
    KKFriendStatusTransferValid,
    KKFriendStatusInvited,
};

NS_ASSUME_NONNULL_BEGIN

@interface KKFriend : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) KKFriendStatus status;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSDate *updateDate;

- (instancetype)initWithName:(NSString *)name
                      status:(KKFriendStatus)status
                       isTop:(BOOL)isTop
                         fid:(NSString *)fid
                  updateDate:(NSDate *)updateDate;

@end

NS_ASSUME_NONNULL_END
