//
//  UIViewController+utils.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (childViewController)

- (void)addChildViewController:(UIViewController *)child to:(UIView *)view;
- (void)add:(UIViewController *)childViewController to:(UIView *)container duration:(NSTimeInterval)duration;
- (void)removeWithDuration:(NSTimeInterval)duration;
- (void)remove;

@end

NS_ASSUME_NONNULL_END
