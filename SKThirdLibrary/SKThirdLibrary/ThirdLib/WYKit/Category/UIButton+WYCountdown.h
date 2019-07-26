//
//  UIButton+WYCountdown.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIButton (WYCountdown)

/**
 *  倒计时按钮 ——> 适用于设置背景颜色的按钮
 *
 *  @param timeLine   倒计时总时间
 *  @param title      还没倒计时的title
 *  @param cTitle     倒计时中的前缀文字
 *  @param subTitle   倒计时中的前缀名字，如时、分
 *  @param mColor     还没倒计时的背景颜色
 *  @param color      倒计时中的背景颜色
 */
- (void)startWithTime:(NSInteger)timeLine
                title:(NSString *)title
           countTitle:(NSString *)cTitle
       countDownTitle:(NSString *)subTitle
            mainColor:(UIColor *)mColor
           countColor:(UIColor *)color;


/**
 *  倒计时按钮 ——> 适用于设定好不可点击状态背景图的按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param cTitle   倒计时中的前缀文字
 *  @param subTitle 倒计时中的子名字，如时、分
 */
- (void)startWithTime:(NSInteger)timeLine
                title:(NSString *)title
           countTitle:(NSString *)cTitle
       countDownTitle:(NSString *)subTitle;


@end
