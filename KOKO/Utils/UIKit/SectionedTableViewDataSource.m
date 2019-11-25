//
//  SectionedTableViewDataSource.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "SectionedTableViewDataSource.h"

@interface SectionedTableViewDataSource ()
@property (nonatomic, strong) NSArray<id<UITableViewDataSource>> *dataSources;
@end

@implementation SectionedTableViewDataSource

+ (instancetype)dataSources:(NSArray<id<UITableViewDataSource>> *)dataSources {
    return [[self alloc] initWithDataSources:dataSources];
}

- (instancetype)initWithDataSources:(NSArray<id<UITableViewDataSource>> *)dataSources {
    self = [super init];
    if (self) {
        self.dataSources = dataSources;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources[section] tableView:tableView numberOfRowsInSection:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<UITableViewDataSource> dataSource = self.dataSources[indexPath.section];
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    return [dataSource tableView:tableView cellForRowAtIndexPath:index];
}

@end
