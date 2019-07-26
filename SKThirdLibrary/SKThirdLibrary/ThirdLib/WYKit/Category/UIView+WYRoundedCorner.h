//
//  UIView+WYRoundedCorner.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIView (WYRoundedCorner)

/** 该类设置圆角的原理为在 view 的最上层绘制一张相应的遮罩图片，
 *  图片的背景只要保证和 view 的父视图背景色一样，就能达到圆角的效果
 */



/** 设置一个四角圆角 */
- (void)roundedCornerWithRadius:(CGFloat)radius
                    cornerColor:(UIColor *)color;

/** 设置一个自定义圆角 */
- (void)roundedCornerWithRadius:(CGFloat)radius
                    cornerColor:(UIColor *)color
                        corners:(UIRectCorner)corners;

/** 设置一个带边框的圆角 */
- (void)roundedCornerWithCornerRadii:(CGSize)cornerRadii
                            cornerColor:(UIColor *)color
                                corners:(UIRectCorner)corners
                            borderColor:(UIColor *)borderColor
                            borderWidth:(CGFloat)borderWidth;

@end





@interface CALayer (WYRoundedCorner)

@property (nonatomic, strong) UIImage *contentImage;//contents的便捷设置


/**如下分别对应 UIView 的相应API */

- (void)roundedCornerWithRadius:(CGFloat)radius
                    cornerColor:(UIColor *)color;

- (void)roundedCornerWithRadius:(CGFloat)radius
                    cornerColor:(UIColor *)color
                        corners:(UIRectCorner)corners;

- (void)roundedCornerWithCornerRadii:(CGSize)cornerRadii
                         cornerColor:(UIColor *)color
                             corners:(UIRectCorner)corners
                         borderColor:(UIColor *)borderColor
                         borderWidth:(CGFloat)borderWidth;

@end
