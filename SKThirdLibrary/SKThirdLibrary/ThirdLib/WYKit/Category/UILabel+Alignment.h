//
//  UILabel+Alignment.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UILabel (Alignment)

/** 两端对齐 */
- (void)textAlignmentLeftAndRight;

/** 指定Label以最后的冒号对齐的width两端对齐 */
- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth;


@end
