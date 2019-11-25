//
//  KKFriendListSectionHeaderView.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKFriendListSectionHeaderView : UITableViewHeaderFooterView

+ (NSString *)reuseIdentifier;
+ (UINib *)nib;

@property (weak, nonatomic) IBOutlet UILabel *friendListLabel;
@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

NS_ASSUME_NONNULL_END
