//
//  KKNavigationController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKNavigationController.h"
#import "UIColor+KK.h"

@interface KKNavigationController ()

@end

@implementation KKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor kkPrimaryPink]];
    [self.navigationBar setTranslucent:false];
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

@end
