//
//  GHWaterFallCell.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHWaterFallCell;
NS_ASSUME_NONNULL_BEGIN
//typedef void(^GHWaterFallResult)(GHWaterFallCell *currentView,CGFloat height);
@interface GHWaterFallCell : UICollectionViewCell
//- (void)getCellHeight:(GHWaterFallResult)handler;
- (CGFloat)getCellHeight;
@end

NS_ASSUME_NONNULL_END
