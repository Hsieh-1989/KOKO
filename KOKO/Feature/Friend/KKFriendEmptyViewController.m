//
//  KKFriendEmptyViewController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "KKFriendEmptyViewController.h"
#import "UIColor+KK.h"
#import "UIFont+KK.h"
#import "NSMutableAttributedString+utils.h"
#import "UIButton+KK.h"
#import "GradientButton.h"
#import "UIImage+KK.h"

@interface KKFriendEmptyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitlelabel;
@property (weak, nonatomic) IBOutlet GradientButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@end

@implementation KKFriendEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    // title
    self.titleLabel.font = [UIFont kkFontOfSize:21 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor kkGreyishBrown];
    self.titleLabel.text = @"就從加好友開始吧：）";
    // sub
    self.subTitlelabel.font = [UIFont kkFontOfSize:14 weight:UIFontWeightRegular];
    self.subTitlelabel.textColor = [UIColor kkWarmGray];
    self.subTitlelabel.text = @"與好友們一起用 KOKO\r快速轉帳最方便！";
    // add btn
    [self.addFriendButton setGreenStyleOfText:@"加好友" icon:[UIImage kkAddFriendWhite]];
    // info
    self.infoLabel.font = [UIFont kkFontOfSize:14 weight:UIFontWeightRegular];
    self.infoLabel.textColor = [UIColor kkWarmGray];
    self.infoLabel.text = @"幫助好友更快找到你";
    // setting btn
    [self.settingButton setUnderlinePrimaryPinkStyleWithText:@"設定 KOKO ID"];
}

#pragma mark - IBAction

- (IBAction)addFriendButtonDidTap:(id)sender {
    
}

- (IBAction)settingButtonDidTap:(id)sender {
    
}

#pragma mark - storyboardloadable
+ (nonnull instancetype)initFromStoryboard {
    return [self initWithBoard:KKStoryBoardFriend];
}

@end

