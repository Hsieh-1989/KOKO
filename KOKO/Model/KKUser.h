//
//  KKUser.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface KKUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *kokoid;

- (instancetype)initWithName:(NSString *)name kokoid:(NSString *)kokoid;

@end

NS_ASSUME_NONNULL_END
