//
//  UIViewController+utils.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "UIViewController+utils.h"

@implementation UIViewController (childViewController)

- (void)addChildViewController:(UIViewController *)child to:(UIView *)view {
    [self addChildViewController:child];
    [view addSubview:child.view];
    child.view.frame = view.bounds;
    [child.view setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [child didMoveToParentViewController:self];
}


- (void)add:(UIViewController *)childViewController to:(UIView *)container duration:(NSTimeInterval)duration {
    [self addChildViewController:childViewController];
    [container addSubview:childViewController.view];
    childViewController.view.frame = container.bounds;
    [childViewController.view setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    if (duration > 0) {
        childViewController.view.alpha = 0;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            childViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)removeWithDuration:(NSTimeInterval)duration {
    if (duration <= 0) {
        [self remove];
        return;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self remove];
    }];
    
}

- (void)remove {
    if (self.parentViewController == nil) {
        return;
    }
    [self willMoveToParentViewController:nil];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

@end
