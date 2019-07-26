//
//  UIButton+Badge.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIButton (Badge)

@property (strong, nonatomic) UILabel *badge;



/** 消息数量 */
@property (nonatomic) NSString *badgeValue;

/** 消息背景色 */
@property (nonatomic) UIColor *badgeBGColor;

/** 消息字体颜色 */
@property (nonatomic) UIColor *badgeTextColor;

/** 字体大小 */
@property (nonatomic) UIFont *badgeFont;

// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;

/** 角标最小尺寸 */
@property (nonatomic) CGFloat badgeMinSize;

// 位置
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;

/** 当数量为0的时候是否显示 */
@property BOOL shouldHideBadgeAtZero;

/** 是否开始动画 */
@property BOOL shouldAnimateBadge;

@end
