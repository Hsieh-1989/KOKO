//
//  NSDateFormatter+utils.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/23.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "NSDateFormatter+utils.h"

@implementation NSDateFormatter (utils)

+ (NSDateFormatter *)dateFormat:(NSString *)format {
    static NSCache<NSString *, NSDateFormatter *> *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    NSDateFormatter *formatter = [cache objectForKey:format];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = format;
        [cache setObject:formatter forKey:format];
    }
    return formatter;
}

@end
