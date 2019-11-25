//
//  NSURLSession+JSON.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * _Nonnull const KKNetworkErrorDomain;

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetworkErrorCallback)(NSError *error);
typedef void(^JSONResponseCallback)(NSDictionary<NSString *, id> *respone);
typedef void(^BundleResponseCallback)(NSDictionary<NSURL *, NSDictionary<NSString *, id> *> *respone);

@interface NSURLSession (JSON)

- (NSURLSessionDataTask *)loadJSONWithURL:(NSURL *)url
                                  success:(JSONResponseCallback)success
                                  failure:(NetworkErrorCallback)failure;

- (void)parallelJSONRequests:(NSArray<NSURL *> *)requests
                     success:(BundleResponseCallback)success
                     failure:(NetworkErrorCallback)failure;

@end

NS_ASSUME_NONNULL_END
