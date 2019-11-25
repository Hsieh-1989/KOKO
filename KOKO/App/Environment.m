//
//  Environment.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "Environment.h"

@implementation Environment

+ (Environment *)current {
    static Environment *environment = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        environment = [[Environment alloc] init];
        environment.apiState = APIStateEmpty;
    });
    return environment;
}

@end
