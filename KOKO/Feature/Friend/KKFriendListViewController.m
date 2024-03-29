//
//  KKFriendListViewController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendListViewController.h"
#import "KKFriendListSectionHeaderView.h"
#import "KKFriendTableViewCell+Configure.h"
#import "KKFriendInvitingCell+Configure.h"
#import "TableViewDataSource.h"
#import "SectionedTableViewDataSource.h"
#import "KKFriend.h"
#import "KKFriendListViewModel.h"
#import "UIColor+KK.h"
#import "NSNotification+utils.h"

#pragma mark - type def

typedef NS_ENUM(NSUInteger, KKFriendListSection) {
    KKFriendListSectionInviting,
    KKFriendListSectionSearch,
    KKFriendListSectionList,
};

typedef TableViewDataSource<KKFriendTableViewCell *, KKFriend *> FriendDataSource;
typedef TableViewDataSource<KKFriendInvitingCell *, KKFriend *> InvitingdDataSource;
typedef TableViewDataSource<UITableViewCell *, NSNull *> EmptyDataSource;

#pragma mark - constant

CGFloat const kkFriendListTableViewTopMargin = 24;
CGFloat const kkFriendListTableViewBottomMargin = 24;

#pragma mark - private property

@interface KKFriendListViewController ()<UITableViewDelegate, UITextFieldDelegate>

// ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) KKFriendListViewModel *viewModel;
@property (nonatomic, strong) KKFriendListSectionHeaderView *friendListSectionHeader;

// datasource
@property (nonatomic, strong) FriendDataSource *friendDataSource;
@property (nonatomic, strong) InvitingdDataSource *invitingDataSource;
@property (nonatomic, strong) SectionedTableViewDataSource *datasource;

// dispoable
@property (nonatomic, strong) NSMutableArray *keyboardObservers;

@end

@implementation KKFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeObserver];
}

- (void)setupUI {
    [self.tableView registerNib:[KKFriendListSectionHeaderView nib] forHeaderFooterViewReuseIdentifier:[KKFriendListSectionHeaderView reuseIdentifier]];
    [self.tableView registerNib:[KKFriendTableViewCell nib] forCellReuseIdentifier:[KKFriendTableViewCell cellIdentifier]];
    [self.tableView registerNib:[KKFriendInvitingCell nib] forCellReuseIdentifier:[KKFriendInvitingCell cellIdentifier]];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    self.refreshControl.tintColor = [UIColor kkPrimaryPink];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.contentInset = UIEdgeInsetsMake(kkFriendListTableViewTopMargin, 0, 0, 0);
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    self.view.preservesSuperviewLayoutMargins = YES;
    self.tableView.preservesSuperviewLayoutMargins = YES;
}

- (void)addObserver {
    id keyboardShowObserver = [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardWillShowNotification
                                                                              object:nil
                                                                               queue:nil
                                                                          usingBlock:^(NSNotification * _Nonnull note) {
        CGRect rect = [self.view convertRect:self.view.bounds toView:nil];
        CGFloat bottomOffset = CGRectGetMaxY(rect) - [note getKeyboardInfo].frameEnd.origin.y + kkFriendListTableViewBottomMargin;
        
        self.tableView.contentInset = UIEdgeInsetsMake(kkFriendListTableViewTopMargin, 0, bottomOffset, 0);
    }];
    id keyboardHideObserver = [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardWillHideNotification
                                                                              object:nil
                                                                               queue:nil
                                                                          usingBlock:^(NSNotification * _Nonnull note) {
        self.tableView.contentInset = UIEdgeInsetsMake(kkFriendListTableViewTopMargin, 0, 0, 0);
    }];
    [self.keyboardObservers addObjectsFromArray:@[keyboardShowObserver, keyboardHideObserver]];
}

- (void)removeObserver {
    for (id observer in self.keyboardObservers) {
        [NSNotificationCenter.defaultCenter removeObserver:observer];
    }
    [self.keyboardObservers removeAllObjects];
}

- (void)reloadData {
    if (_reloadFrientList) {
        _reloadFrientList();
    }
}

#pragma mark - setter
- (void)resetFriendList:(NSArray<KKFriend *> *)friendList {
    [self.refreshControl endRefreshing];
    [UIView setAnimationsEnabled:NO];
    [self.viewModel reloadFriendList:friendList];
    [UIView setAnimationsEnabled:YES];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:KKFriendListSectionSearch] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - lazy property
- (KKFriendListViewModel *)viewModel {
    if (_viewModel == nil) {
        __weak typeof(self) weakSelf = self;
        _viewModel = [[KKFriendListViewModel alloc] initWithValidFriendListUpdate:^{
            [weakSelf.friendDataSource resetItems:self.viewModel.validFriendList];
            [weakSelf.tableView beginUpdates];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:KKFriendListSectionList] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView endUpdates];
        } invitingFriendListUpdate:^{
            [weakSelf.invitingDataSource resetItems:self.viewModel.invitingFriendList];
            [weakSelf.tableView beginUpdates];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:KKFriendListSectionInviting] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView endUpdates];
        }];
    }
    return _viewModel;
}

- (SectionedTableViewDataSource *)datasource {
    if (_datasource == nil) {
        EmptyDataSource *empty = [[EmptyDataSource alloc] initWithItems:@[]
                                                             identifier:@"cell"
                                                              configure:^(UITableViewCell * _Nonnull cell, NSNull * _Nonnull item) {}];
        _datasource = [SectionedTableViewDataSource dataSources:@[
            self.invitingDataSource,
            empty,
            self.friendDataSource
        ]];
    }
    return _datasource;
}

- (FriendDataSource *)friendDataSource {
    if (_friendDataSource == nil) {
        _friendDataSource = [[FriendDataSource alloc] initWithItems:self.viewModel.validFriendList
                                                         identifier:KKFriendTableViewCell.cellIdentifier
                                                          configure:^(KKFriendTableViewCell * _Nonnull cell, KKFriend * _Nonnull friend) {
            [cell configureWithFriend:friend];
        }];
    }
    return _friendDataSource;
}

- (InvitingdDataSource *)invitingDataSource {
    if (_invitingDataSource == nil) {
        __weak typeof(self) weakSelf = self;
        _invitingDataSource = [[InvitingdDataSource alloc] initWithItems:self.viewModel.invitingFriendList
                                                              identifier:KKFriendInvitingCell.cellIdentifier
                                                               configure:^(KKFriendInvitingCell * _Nonnull cell, KKFriend * _Nonnull friend) {
            [cell configureWithFriend:friend isExpanded:weakSelf.viewModel.isInvitingSectionExpand];
        }];
    }
    return _invitingDataSource;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == KKFriendListSectionInviting && indexPath.row == 0) {
        [self.viewModel toggleInvitingListExpandingState];
    }
}

// Header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if (section == KKFriendListSectionSearch) {
        return 93;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == KKFriendListSectionSearch) {
        KKFriendListSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[KKFriendListSectionHeaderView reuseIdentifier]];
        header.searchTextField.delegate = self;
        header.friendListLabel.text = self.viewModel.listInfoText;
        return header;
    } else {
        return nil;
    }
}

// Footer
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = UIColor.clearColor;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kkFriendListTableViewBottomMargin;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.viewModel searchDidStart];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:NSNotFound inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *searchText = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    [self.viewModel searchByText:searchText];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.viewModel searchDidEnd];
}

#pragma mark - storyboardloadable
+ (nonnull instancetype)initFromStoryboard {
    return [self initWithBoard:KKStoryBoardFriend];
}

@end
