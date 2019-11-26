//
//  KKFriendListContainerController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendListContainerController.h"
#import "KKFriendEmptyViewController.h"
#import "KKFriendListViewController.h"
#import "UIViewController+utils.h"
#import "UIColor+KK.h"
#import "KKAPIClient.h"

@interface KKFriendListContainerController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) KKFriendListViewController *listViewController;
@property (nonatomic, strong) UIViewController *contentViewController;

@end

@implementation KKFriendListContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadFriendList];
}

- (void)setupUI {
    self.viewRespectsSystemMinimumLayoutMargins = NO;
    self.view.preservesSuperviewLayoutMargins = YES;
    self.spinner.color = UIColor.kkPrimaryPink;
    self.spinner.hidesWhenStopped = YES;
    [self.spinner startAnimating];
}

- (void)loadFriendList {
    [self.spinner startAnimating];
    [[KKAPIClient shared] requestFriendListSuccess:^(NSArray<KKFriend *> * _Nonnull friendList) {
        [self.spinner stopAnimating];
        if (friendList.count == 0) {
            [self updateContentViewController:[KKFriendEmptyViewController initFromStoryboard]];
        } else {
            [self.listViewController resetFriendList:friendList];
            [self updateContentViewController:self.listViewController];
        }

    } failure:^(NSError * _Nonnull error) {
        NSLog(@"load friend list error: %@", error.localizedDescription);
    }];
}

- (void)updateContentViewController:(UIViewController *)contentViewController {
    if (contentViewController == _contentViewController) {
        return;
    }
    [_contentViewController removeWithDuration:0.4];
    _contentViewController = contentViewController;
    [self add:_contentViewController to:self.view duration:0.4];
}

#pragma mark - private helper


#pragma mark - Lazy property
- (KKFriendListViewController *)listViewController {
    if (_listViewController == nil) {
        _listViewController = [KKFriendListViewController initFromStoryboard];
        __weak typeof(self) weakSelf = self;
        _listViewController.reloadFrientList = ^{
            [weakSelf loadFriendList];
        };
    }
    return _listViewController;
}

@end
