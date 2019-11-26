//
//  NSNotification+utils.h
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/26.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardInfo : NSObject

@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) BOOL isLocal;
@property (nonatomic, assign) CGRect frameBegin;
@property (nonatomic, assign) CGRect frameEnd;

@end

@interface NSNotification (utils)

- (nullable KeyboardInfo *)getKeyboardInfo;

@end

NS_ASSUME_NONNULL_END
