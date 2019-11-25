//
//  UIViewController+KK.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "UIViewController+KK.h"

#pragma mark - kk storyboard
@interface UIStoryboard (KK)
+ (instancetype)initWithBoard:(KKStoryBoard)board;
@end


#pragma mark -
@implementation UIViewController (KK)

+ (NSString *)storyboardIdentifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)initWithBoard:(KKStoryBoard)board {
    UIStoryboard *storyBoard = [UIStoryboard initWithBoard:board];
    return [storyBoard instantiateViewControllerWithIdentifier:self.storyboardIdentifier];
}

@end

#pragma mark - kk storyboard imp
@implementation UIStoryboard (KK)

+ (instancetype)initWithBoard:(KKStoryBoard)board {
    NSString *name;
    switch (board) {
        case KKStoryBoardMain:
            name = @"Main";
            break;
        case KKStoryBoardFriend:
            name = @"Friend";
            break;
    }
    return [UIStoryboard storyboardWithName:name bundle:nil];
}

@end
