//
//  KKStubURLProtocol.h
//  KOKOTests
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StubbedResponse : NSObject

@property (nonatomic, strong, nullable) NSHTTPURLResponse *response;
@property (nonatomic, strong, nullable) NSData *data;
@property (nonatomic, strong, nullable) NSError *error;

+ (instancetype)url:(NSURL *)url data:(NSData *)data;
+ (instancetype)url:(NSURL *)url jsonFileName:(NSString *)fileName ofType:(NSString *)type;
+ (instancetype)error:(NSError *)error;
- (instancetype)initWithResponse:(nullable NSHTTPURLResponse *)response data:(nullable NSData *)data error:(nullable NSError *)error;

@end

@interface KKStubURLProtocol : NSURLProtocol
+ (void)setResponse:(NSDictionary<NSURL *, StubbedResponse *> *)response;
@end

NS_ASSUME_NONNULL_END
