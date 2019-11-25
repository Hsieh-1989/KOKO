//
//  KKAPIRequest.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKAPIRequest.h"
#import "NSURLSession+JSON.h"

@interface KKAPIRequest()

@end

@implementation KKAPIRequest

+ (instancetype)requestWithURL:(NSURL *)url parseJSON:(id  _Nullable (^)(NSDictionary<NSString *,id> * _Nonnull json))parseJSON {
    return [[self alloc] initWithURL:url parseJSON:parseJSON];
}

- (instancetype)initWithURL:(NSURL *)url parseJSON:(id  _Nullable (^)(NSDictionary<NSString *,id> * _Nonnull json))parseJSON {
    self = [super init];
    if (self) {
        _url = url;
        _parseJSON = parseJSON;
    }
    return self;
}

@end
