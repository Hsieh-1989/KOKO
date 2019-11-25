//
//  KKFriendViewController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendViewController.h"
#import "KKUserHeaderView+Configure.h"
#import "KKAPIClient.h"
#import "UIColor+KK.h"
#import "Environment.h"

@interface KKFriendViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *contentSeparator;
@property (weak, nonatomic) IBOutlet KKUserHeaderView *userHeaderView;

@end

@implementation KKFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self requestData];
}

- (void)setupUI {
    self.contentSeparator.backgroundColor = [UIColor kkContentSeparatorGray];
    self.viewRespectsSystemMinimumLayoutMargins = NO;
    self.view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(self.view.directionalLayoutMargins.top, 30, self.view.directionalLayoutMargins.bottom, 30);
    self.userHeaderView.preservesSuperviewLayoutMargins = YES;
    self.containerView.preservesSuperviewLayoutMargins = YES;
}

- (void)requestData {
    // request user info
    [[KKAPIClient shared] requestUserSuccess:^(KKUser * _Nonnull user) {
        [self.userHeaderView configureWithUser:user];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"load user error: %@", error.localizedDescription);
    }];
}

@end
