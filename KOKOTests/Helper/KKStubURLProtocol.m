//
//  KKStubURLProtocol.m
//  KOKOTests
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKStubURLProtocol.h"

@implementation StubbedResponse : NSObject

+ (instancetype)url:(NSURL *)url data:(NSData *)data {
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:nil headerFields:nil];
    return [[self alloc] initWithResponse:response data:data error:nil];
}

+ (instancetype)url:(NSURL *)url jsonFileName:(NSString *)fileName ofType:(NSString *)type {
    NSString *path = [[NSBundle bundleForClass:self] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [self url:url data:data];
}

+ (instancetype)error:(NSError *)error {
    return [[self alloc] initWithResponse:nil data:nil error:error];
}

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error{
    self = [super init];
    if (self) {
        self.response = response;
        self.data = data;
        self.error = error;
    }
    return self;
}

@end

@implementation KKStubURLProtocol

static NSDictionary<NSURL *, StubbedResponse *> *_response = nil;

+ (void)setResponse:(NSDictionary<NSURL *, StubbedResponse *> *)response {
    _response = response;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [_response.allKeys containsObject:request.URL];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return NO;
}

- (void)startLoading {
    StubbedResponse *response = _response[self.request.URL];
    if (response.error) {
        [self.client URLProtocol:self didFailWithError:response.error];
    } else {
        [self.client URLProtocol:self didReceiveResponse:response.response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:response.data];
    }
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
    
}


@end
