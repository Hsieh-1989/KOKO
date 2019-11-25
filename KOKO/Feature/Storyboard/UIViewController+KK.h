//
//  UIViewController+KK.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KKStoryBoard) {
    KKStoryBoardMain,
    KKStoryBoardFriend
};

@protocol StoryboardLoadable <NSObject>

+ (instancetype)initFromStoryboard;

@end


@interface UIViewController (KK)

+ (NSString *)storyboardIdentifier;
+ (instancetype)initWithBoard:(KKStoryBoard)board;

@end

NS_ASSUME_NONNULL_END
