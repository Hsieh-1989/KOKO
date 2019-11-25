//
//  KKAPIClient.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKAPIClient.h"
#import "NSURLSession+JSON.h"
#import "KKUser.h"
#import "KKFriend.h"
#import "Environment.h"

#pragma mark - APIRequest helper
@interface KKAPIRequest<Response> (SessionHelper)
- (NSURLSessionDataTask *)loadBySession:(NSURLSession *)session success:(void(^)(Response response))success failure:(void(^)(NSError * error))failure;
@end


@interface KKAPIClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation KKAPIClient

#pragma mark - Initializer

+ (KKAPIClient *)shared {
    static KKAPIClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[KKAPIClient alloc] initWithSession:[NSURLSession sharedSession]];
    });
    return client;
}

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        self.session = session;
    }
    return self;
}

#pragma mark - public method
- (void)requestUserSuccess:(RequestUserCallback)success failure:(ErrorCallback)failure {
    [[KKAPIRequest user] loadBySession:self.session success:^(KKUser *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            success(response);
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });
    }];
}

- (void)requestFriendListSuccess:(RequestFriendListCallback)success failure:(ErrorCallback)failure {
    switch ([Environment current].apiState) {
        case APIStateEmpty:
            [self requestFriendListWithType:KKFriendListTypeFriendListWithoutInvitation success:success failure:failure];
            break;
            
        case APIStateListWithoutInvitation:
            [self requestFriendListWithOutInvitationSuccessSuccess:success failure:failure];
            break;
            
        case APIStateListWithInvitation:
            [self requestFriendListWithInvitationSuccess:success failure:failure];
            break;
    }
}

- (void)requestFriendListWithOutInvitationSuccessSuccess:(RequestFriendListCallback)success failure:(ErrorCallback)failure {
    
    KKAPIRequest<NSArray<KKFriend *> *> *request1 = [KKAPIRequest friendListOfType:KKFriendListType1];
    KKAPIRequest<NSArray<KKFriend *> *> *request2 = [KKAPIRequest friendListOfType:KKFriendListType2];
    
    [self.session parallelJSONRequests:@[request1.url, request2.url] success:^(NSDictionary<NSURL *,NSDictionary<NSString *,id> *> * _Nonnull respone) {
        
        NSArray<KKFriend *> *list1 = request1.parseJSON(respone[request1.url]);
        NSArray<KKFriend *> *list2 = request2.parseJSON(respone[request2.url]);
        
        NSMutableDictionary<NSString *, KKFriend *> *dict = [NSMutableDictionary dictionaryWithObjects:list1
                                                                                               forKeys:[list1 valueForKey:@"fid"]];
        
        for (KKFriend *friend in list2) {
            KKFriend *origional = dict[friend.fid];
            // compare with date
            if (origional == nil || [origional.updateDate compare:friend.updateDate] == NSOrderedAscending) {
                dict[friend.fid] = friend;
            }
        }
        
        // sorted by date
        NSArray<KKFriend *> *result = [[dict allValues] sortedArrayUsingComparator:^NSComparisonResult(KKFriend * _Nonnull obj1, KKFriend * _Nonnull obj2) {
            return [obj1.updateDate compare:obj2.updateDate];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(result);
        });
        
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });
    }];
}

- (void)requestFriendListWithInvitationSuccess:(RequestFriendListCallback)success failure:(ErrorCallback)failure {
    
    KKAPIRequest<NSArray<KKFriend *> *> *request1 = [KKAPIRequest friendListOfType:KKFriendListType1];
    KKAPIRequest<NSArray<KKFriend *> *> *request2 = [KKAPIRequest friendListOfType:KKFriendListType2];
    KKAPIRequest<NSArray<KKFriend *> *> *request3 = [KKAPIRequest friendListOfType:KKFriendListTypeFriendListWithInvitation];
    
    [self.session parallelJSONRequests:@[request1.url, request2.url, request3.url] success:^(NSDictionary<NSURL *,NSDictionary<NSString *,id> *> * _Nonnull respone) {
        
        NSArray<KKFriend *> *list1 = request1.parseJSON(respone[request1.url]);
        NSArray<KKFriend *> *list2 = request2.parseJSON(respone[request2.url]);
        NSArray<KKFriend *> *list3 = request3.parseJSON(respone[request3.url]);
        
        NSMutableDictionary<NSString *, KKFriend *> *dict = [NSMutableDictionary dictionaryWithObjects:list1
                                                                                               forKeys:[list1 valueForKey:@"fid"]];
        for (KKFriend *friend in [list2 arrayByAddingObjectsFromArray:list3]) {
            KKFriend *origional = dict[friend.fid];
            // compare with date
            if (origional == nil || [origional.updateDate compare:friend.updateDate] == NSOrderedAscending) {
                dict[friend.fid] = friend;
            }
        }
        
        // sorted by date
        NSArray<KKFriend *> *result = [[dict allValues] sortedArrayUsingComparator:^NSComparisonResult(KKFriend * _Nonnull obj1, KKFriend * _Nonnull obj2) {
            return [obj1.updateDate compare:obj2.updateDate];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(result);
        });
        
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });
    }];
}

- (void)requestFriendListWithType:(KKFriendListType)type success:(RequestFriendListCallback)success failure:(ErrorCallback)failure {
    [[KKAPIRequest friendListOfType:type] loadBySession:self.session success:^(NSArray<KKFriend *> *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            success(response);
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });
    }];
}

@end

#pragma mark - APIRequest helper

@implementation KKAPIRequest (SessionHelper)

- (NSURLSessionDataTask *)loadBySession:(NSURLSession *)session success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    return [session loadJSONWithURL:self.url success:^(NSDictionary<NSString *,id> * _Nonnull respone) {
        id result = self.parseJSON(respone);
        if (result) {
            success(result);
        } else {
            failure([NSError errorWithDomain:KKNetworkErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil]);
        }
    } failure:failure];
}

@end
