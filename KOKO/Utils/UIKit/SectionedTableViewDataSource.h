//
//  SectionedTableViewDataSource.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/24.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionedTableViewDataSource : NSObject<UITableViewDataSource>

+ (instancetype)dataSources:(NSArray<id<UITableViewDataSource>> *)dataSources;

@end

NS_ASSUME_NONNULL_END
