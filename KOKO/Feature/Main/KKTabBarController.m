//
//  KKTabBarController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKTabBarController.h"
#import "UIColor+KK.h"

@interface KKTabBarController ()

@end

@implementation KKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.tabBar.tintColor = [UIColor kkPrimaryPink];
    self.tabBar.unselectedItemTintColor = [UIColor kkTabItemGray];
}

@end
