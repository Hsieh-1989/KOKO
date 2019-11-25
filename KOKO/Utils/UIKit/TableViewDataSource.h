//
//  TableViewDataSource.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/22.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewDataSource<Cell: UITableViewCell *, Item> : NSObject<UITableViewDataSource>

- (instancetype)initWithItems:(NSArray<Item> *)items identifier:(NSString *)identifier configure:(void (^)(Cell, Item))configure;
- (Item)itemAtIndexPath:(NSIndexPath *)indexPath;
- (void)resetItems:(NSArray<Item> *)items;

@end

NS_ASSUME_NONNULL_END
