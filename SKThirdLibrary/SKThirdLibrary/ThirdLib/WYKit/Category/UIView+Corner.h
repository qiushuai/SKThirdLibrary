//
//  UIView+Corner.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WYCornerPosition) {
    
    // 单边设置
    WYCornerPositionTopLeft = 0,        // 上左
    WYCornerPositionTopRight,           // 上右
    WYCornerPositionBottomLeft,         // 下左   
    WYCornerPositionBottomRight,        // 下又
    
    // 多边设置
    WYCornerPositionTop = 99,           // 上左上右
    WYCornerPositionBottom,             // 下左上右
    WYCornerPositionLeft,               // 上左下左
    WYCornerPositionRight,              // 上右下右
    
    WYCornerPositionAll
    
};

@interface UIView (Corner)

@property (nonatomic, assign) WYCornerPosition wy_cornerPosition;
@property (nonatomic, assign) CGFloat wy_cornerRadius;

- (void)setCornerOnTopWithRadius:(CGFloat)radius;
- (void)setCornerOnLeftWithRadius:(CGFloat)radius;
- (void)setCornerOnBottomWithRadius:(CGFloat)radius;
- (void)setCornerOnRightWithRadius:(CGFloat)radius;
- (void)setAllCornerWithCornerRadius:(CGFloat)radius;
- (void)setNoneCorner;


@end
