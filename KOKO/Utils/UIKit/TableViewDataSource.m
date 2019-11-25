//
//  TableViewDataSource.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/22.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "TableViewDataSource.h"

@interface TableViewDataSource()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) void (^configure)(__kindof UITableViewCell *cell, id item);

@end

@implementation TableViewDataSource

- (instancetype)initWithItems:(NSArray *)items
                   identifier:(NSString *)identifier
                    configure:(void (^)(UITableViewCell * _Nonnull, id _Nonnull))configure {
    self = [super init];
    if (self) {
        self.items = items;
        self.identifier = identifier;
        self.configure = configure;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}

- (void)resetItems:(NSArray *)items {
    self.items = items;
}

#pragma mark - TableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configure(cell, item);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

@end
