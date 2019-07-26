//
//  UIViewController+AZPushAndPop.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIViewController (AZPushAndPop)

/** 循环push同一种ViewController时，控制数量以及返回顺序 */
+ (NSUInteger)az_cyclePushLimitNumber;

@end
