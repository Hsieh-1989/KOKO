//
//  KKAPIRequest.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KKUser;
@class KKFriend;

NS_ASSUME_NONNULL_BEGIN

@interface KKAPIRequest<Response> : NSObject

@property (nonatomic, strong, nonnull, readonly) NSURL *url;
@property (nonatomic, strong, nonnull, readonly) Response _Nullable (^parseJSON)(NSDictionary<NSString *,id> * json);

+ (instancetype)requestWithURL:(NSURL *)url parseJSON:(Response  _Nullable (^)(NSDictionary<NSString *,id> * json))parseJSON;

@end

NS_ASSUME_NONNULL_END


