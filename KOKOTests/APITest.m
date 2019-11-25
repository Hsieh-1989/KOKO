//
//  APITest.m
//  KOKOTests
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KKStubURLProtocol.h"
#import "KKAPIClient.h"
#import "KKUser.h"
#import "KKFriend.h"
#import "NSDateFormatter+utils.h"
#import "Environment.h"

static NSString * const KKTestErrorDomain = @"com.kk.test.error";

@interface APITest : XCTestCase

@end

@implementation APITest

- (void)setUp {
    [super setUp];
    [NSURLProtocol registerClass:[KKStubURLProtocol class]];
}

- (void)tearDown {
    [super tearDown];
    [NSURLProtocol unregisterClass:[KKStubURLProtocol class]];
}

- (void)testUserAPI {
    NSURL *url = [NSURL URLWithString:@"https://dimanyen.github.io/man.json"];
    [KKStubURLProtocol setResponse:@{
        url: [StubbedResponse url:url jsonFileName:@"man" ofType:@"json"]
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stubbed network call"];
    [[KKAPIClient shared] requestUserSuccess:^(KKUser * _Nonnull user) {
        
        XCTAssert([user.name isEqualToString:@"蔡國泰"]);
        XCTAssert([user.kokoid isEqualToString:@"Mike"]);
        [expectation fulfill];
        
    } failure:^(NSError * _Nonnull error) {
        XCTFail(@"%@", error.localizedDescription);
    }];
    
    [self waitForExpectations:@[expectation] timeout:1];
}

- (void)testUserAPIParseError {
    NSURL *url = [NSURL URLWithString:@"https://dimanyen.github.io/man.json"];
    NSString *jsonString = @"{ \"response\": [ { \"name\": \"蔡國泰\" } ] }";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [KKStubURLProtocol setResponse:@{
        url: [StubbedResponse url:url data:data]
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stubbed network call"];
    [[KKAPIClient shared] requestUserSuccess:^(KKUser * _Nonnull user) {
        XCTFail(@"should not get call when error occur");
    } failure:^(NSError * _Nonnull error) {
        XCTAssert(true);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:1];
}

- (void)testUserAPIResponseError {
    NSURL *url = [NSURL URLWithString:@"https://dimanyen.github.io/man.json"];
    NSError *error = [NSError errorWithDomain:KKTestErrorDomain code:NSURLErrorBadServerResponse userInfo:nil];
    [KKStubURLProtocol setResponse:@{
        url: [StubbedResponse error:error]
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stubbed network call"];
    [[KKAPIClient shared] requestUserSuccess:^(KKUser * _Nonnull user) {
        XCTFail(@"should not get call when error occur");
    } failure:^(NSError * _Nonnull error) {
        XCTAssert(true);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:1];
}

- (void)testFriendListAPI {
    [Environment current].apiState = APIStateListWithoutInvitation;
    NSURL *list1 = [NSURL URLWithString:@"https://dimanyen.github.io/friend1.json"];
    NSURL *list2 = [NSURL URLWithString:@"https://dimanyen.github.io/friend2.json"];
    [KKStubURLProtocol setResponse:@{
        list1: [StubbedResponse url:list1 jsonFileName:@"friend1" ofType:@"json"],
        list2: [StubbedResponse url:list2 jsonFileName:@"friend2" ofType:@"json"]
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stubbed network call"];
    [[KKAPIClient shared] requestFriendListSuccess:^(NSArray<KKFriend *> * _Nonnull friendList) {
        NSDictionary *expected = [self combinedFriendList];
        [friendList enumerateObjectsUsingBlock:^(KKFriend * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *friend = expected[obj.fid];
            if (friend) {
                XCTAssert([self assertFriend:obj dictionary:friend]);
            } else {
                XCTFail(@"should not contain friend: %@", obj);
            }
        }];
        [expectation fulfill];
    } failure:^(NSError * _Nonnull error) {
        XCTFail(@"%@", error.localizedDescription);
    }];
    
    [self waitForExpectations:@[expectation] timeout:1];
}

- (void)testFriendListAPIResponseError {
    [Environment current].apiState = APIStateListWithoutInvitation;
    NSURL *list1 = [NSURL URLWithString:@"https://dimanyen.github.io/friend1.json"];
    NSURL *list2 = [NSURL URLWithString:@"https://dimanyen.github.io/friend2.json"];
    NSError *error = [NSError errorWithDomain:KKTestErrorDomain code:NSURLErrorBadServerResponse userInfo:nil];
    [KKStubURLProtocol setResponse:@{
        list1: [StubbedResponse url:list1 jsonFileName:@"friend1" ofType:@"json"],
        list2: [StubbedResponse error:error]
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stubbed network call"];
    [[KKAPIClient shared] requestFriendListSuccess:^(NSArray<KKFriend *> * _Nonnull friendList) {
        XCTFail(@"should not get call when error occur");
    } failure:^(NSError * _Nonnull error) {
        XCTAssert(true);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:1];
}

- (void)testFriendListEmpty {
    NSURL *list1 = [NSURL URLWithString:@"https://dimanyen.github.io/friend4.json"];
    [KKStubURLProtocol setResponse:@{
        list1: [StubbedResponse url:list1 jsonFileName:@"friend4" ofType:@"json"],
    }];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Stubbed network call"];
    [[KKAPIClient shared] requestFriendListWithType:KKFriendListTypeFriendListWithoutInvitation success:^(NSArray<KKFriend *> * _Nonnull friendList) {
        XCTAssert(friendList.count == 0);
        [expectation fulfill];
    } failure:^(NSError * _Nonnull error) {
        XCTFail(@"%@", error.localizedDescription);
    }];
    [self waitForExpectations:@[expectation] timeout:1];
}

#pragma mark - private helper
- (NSDictionary<NSString *, NSDictionary *> *)combinedFriendList {
    NSString *path = [[NSBundle bundleForClass:[APITest class]] pathForResource:@"friend1+2" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray<NSDictionary *> *result = json[@"response"];
    return [NSDictionary dictionaryWithObjects:result forKeys:[result valueForKey:@"fid"]];
}

- (BOOL)assertFriend:(KKFriend *)friend dictionary:(NSDictionary *)dictionary {
    NSDate *date = [[NSDateFormatter dateFormat:@"yyyyMMdd"] dateFromString:dictionary[@"updateDate"]];
    return [dictionary[@"name"] isEqualToString:friend.name]
    && [dictionary[@"status"] isEqualToNumber: @(friend.status)]
    && [dictionary[@"isTop"] isEqualToString:@"1"] == friend.isTop
    && [date isEqualToDate:friend.updateDate];
}

@end
