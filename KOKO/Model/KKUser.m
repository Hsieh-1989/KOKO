//
//  KKUser.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKUser.h"

@implementation KKUser

- (instancetype)initWithName:(NSString *)name kokoid:(NSString *)kokoid {
    self = [super init];
    if (self) {
        self.name = name;
        self.kokoid = kokoid;
    }
    return self;
}

@end
