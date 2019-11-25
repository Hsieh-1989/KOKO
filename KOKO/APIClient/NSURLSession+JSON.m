//
//  NSURLSession+JSON.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "NSURLSession+JSON.h"

NSString * const KKNetworkErrorDomain = @"com.kk.networkError";

#pragma mark - JSONResponseSerializer

@interface JSONResponseSerializer: NSObject

+ (instancetype)serializer;
- (nullable NSDictionary<NSString *, id> *)jsonForResponse:(NSURLResponse *)response
                                                      data:(NSData *)data
                                                     error:(NSError *__autoreleasing *)error;

@end


#pragma mark - NSURLSession + JSON

@implementation NSURLSession (JSON)

- (NSURLSessionDataTask *)loadJSONWithURL:(NSURL *)url success:(JSONResponseCallback)success failure:(NetworkErrorCallback)failure {

    NSURLSessionDataTask *task = [self dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // check error
        if (error) {
            failure(error);
            return;
        }

        // parse response
        JSONResponseSerializer *serializer = [JSONResponseSerializer serializer];
        NSError *serializationError = nil;
        NSDictionary<NSString *, id> * json = [serializer jsonForResponse:response data:data error:&serializationError];

        if (serializationError) {
            failure(error);
        } else {
            success(json);
        }
    }];
    [task resume];
    return task;
}

- (void)parallelJSONRequests:(NSArray<NSURL *> *)requests success:(BundleResponseCallback)success failure:(NetworkErrorCallback)failure {

    NSMutableArray<NSURLSessionDataTask *> *tasks = [NSMutableArray array];
    NSMutableArray<NSError *> *errors = [NSMutableArray array];
    NSMutableDictionary<NSURL *, NSDictionary<NSString *, id> *> *results = [NSMutableDictionary dictionary];

    dispatch_group_t group = dispatch_group_create();
    for (NSURL *url in requests) {
        dispatch_group_enter(group);
        NSURLSessionDataTask *task = [self loadJSONWithURL:url success:^(NSDictionary<NSString *,id> * _Nonnull json) {
            // TODO: should handle parse failure case
            results[url] = json;
            dispatch_group_leave(group);

        } failure:^(NSError * _Nonnull error) {
            // TODO: maybe just cancel all task
            [errors addObject:error];
            dispatch_group_leave(group);
        }];
        [tasks addObject:task];
    }
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (errors.count > 0) {
            [errors enumerateObjectsUsingBlock:^(NSError * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"request error: %@", [obj localizedDescription]);
            }];
            // FIXME: weird error handling
            failure([errors firstObject]);
        } else {
            success([results copy]);
        }
    });
}


@end

#pragma mark - JSONResponseSerializer

@implementation JSONResponseSerializer

+ (instancetype)serializer {
    return [[self alloc] init];
}

- (NSDictionary<NSString *, id> *)jsonForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    // check empty data
    if (data == nil || data.length == 0) {
        *error = [NSError errorWithDomain:KKNetworkErrorDomain code:NSURLErrorZeroByteResource userInfo:nil];
        return nil;
    }
    // TODO: check response code
    
    // parse json
    NSError *serializationError = nil;
    NSDictionary<NSString *, id> * responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
    if (serializationError != nil) {
        *error = serializationError;
        return nil;
    }
    
    if (responseObject == nil) {
        *error = [NSError errorWithDomain:KKNetworkErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];
        return nil;
    }
    
    return responseObject;
}

@end
