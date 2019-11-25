//
//  KKAPIRequest+KKAPI.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKAPIRequest+KKAPI.h"
#import "KKUser.h"
#import "KKFriend.h"
#import "NSDateFormatter+utils.h"

#pragma mark default url
@interface NSURL (KKAPI)
+ (NSURL *)mainListURL;
+ (NSURL *)friendListURLOfType:(KKFriendListType)type;
@end

@interface NSDateFormatter (KKAPI)
+ (NSDateFormatter *)formatterForRequest:(KKFriendListType)type;
@end

#pragma mark -
@implementation KKAPIRequest (KKAPI)

+ (KKAPIRequest<KKUser *> *)user {
    return [KKAPIRequest<KKUser *> requestWithURL:[NSURL mainListURL] parseJSON:^KKUser * _Nullable(NSDictionary<NSString *,id> * _Nonnull json) {
        NSDictionary * user = [json[@"response"] firstObject];
        NSString *name = user[@"name"];
        NSString *kokoid = user[@"kokoid"];
        if (!user || !name || !kokoid) {
            return nil;
        }
        return [[KKUser alloc] initWithName:name kokoid:kokoid];
    }];
}

+ (KKAPIRequest<NSArray<KKFriend *> *> *)friendListOfType:(KKFriendListType)type {
    return [KKAPIRequest<NSArray<KKFriend *> *> requestWithURL:[NSURL friendListURLOfType:type]
                                                   parseJSON:^NSArray<KKFriend *> * _Nullable(NSDictionary<NSString *,id> * _Nonnull json) {
        NSArray<NSDictionary *> *list = json[@"response"];
        NSMutableArray<KKFriend *> *result = [NSMutableArray arrayWithCapacity:list.count];
        
        for (NSDictionary *dict in list) {
            NSString *name = dict[@"name"];
            NSNumber *status = dict[@"status"];
            NSString *isTop = dict[@"isTop"];
            NSString *fid = dict[@"fid"];
            NSString *updateDateString = dict[@"updateDate"];
            NSDateFormatter *formatter = [NSDateFormatter formatterForRequest:type];
            NSDate *updateDate = [formatter dateFromString:updateDateString];
            if(!name || !status || !isTop || !fid || !updateDate || status.integerValue < 0 || status.integerValue > 2) {
                return nil;
            }
            [result addObject: [[KKFriend alloc] initWithName:name
                                                       status:status.integerValue
                                                        isTop:[isTop isEqualToString:@"1"]
                                                          fid:fid
                                                   updateDate:updateDate]];

        }
        
        return [result copy];
        
    }];
}

@end

#pragma mark default url

@implementation NSURL (KKAPI)

+ (NSURL *)mainListURL {
    return [NSURL URLWithString:@"https://dimanyen.github.io/man.json"];
}

+ (NSURL *)friendListURLOfType:(KKFriendListType)type {
    switch (type) {
        case KKFriendListType1:
            return [NSURL URLWithString:@"https://dimanyen.github.io/friend1.json"];
        case KKFriendListType2:
            return [NSURL URLWithString:@"https://dimanyen.github.io/friend2.json"];
        case KKFriendListTypeFriendListWithInvitation:
            return [NSURL URLWithString:@"https://dimanyen.github.io/friend3.json"];
        case KKFriendListTypeFriendListWithoutInvitation:
            return [NSURL URLWithString:@"https://dimanyen.github.io/friend4.json"];
    }
}

@end

@implementation NSDateFormatter (KKAPI)

+ (NSDateFormatter *)formatterForRequest:(KKFriendListType)type {
    switch (type) {
        case KKFriendListType1:
        case KKFriendListTypeFriendListWithInvitation:
        case KKFriendListTypeFriendListWithoutInvitation:
            return [NSDateFormatter dateFormat:@"yyyyMMdd"];
            
        case KKFriendListType2:
            return [NSDateFormatter dateFormat:@"yyyy/MM/dd"];
    }
    
}

@end
