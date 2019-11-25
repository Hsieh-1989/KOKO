//
//  Environment.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, APIState) {
    APIStateEmpty,
    APIStateListWithoutInvitation,
    APIStateListWithInvitation
};

NS_ASSUME_NONNULL_BEGIN

@interface Environment : NSObject
// weird hack for switch api state
@property (nonatomic, assign) APIState apiState;
+ (Environment *)current;

@end

NS_ASSUME_NONNULL_END
