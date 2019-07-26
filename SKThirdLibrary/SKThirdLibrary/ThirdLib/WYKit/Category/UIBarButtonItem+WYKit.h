//
//  UIBarButtonItem+WYKit.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WYKit)

/** 设置NavigationItem的自定义文字图片按钮 */
+ (instancetype)itemWithNomalTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                        nomalImage:(NSString *)nomalImage
                         highImage:(NSString *)highImage
                            target:(id)target
                            action:(SEL)action;

/** 设置NavigationItem的自定义按钮 */
+ (instancetype)itemWithImageName:(NSString *)image
                        highImage:(NSString *)highImage
                           target:(id)target
                           action:(SEL)action;

/** 设置NavigationItem的自定义按下按钮 */
+ (instancetype)itemWithImageName:(NSString *)image
                      selectImage:(NSString *)selectImg
                           target:(id)target
                           action:(SEL)action;

/** 自定义返回按钮 */
+ (instancetype)leftItemWithNomalTitle:(NSString *)title
                            nomalImage:(NSString *)image
                            titleColor:(UIColor *)titleColor
                                target:(id)target
                                action:(SEL)action;

/** 自定义文字按钮 */
+ (instancetype)itemWithNomalTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action;


/** 自定义文字按钮 带文字属性 */
+ (instancetype)itemWithNomalTitle:(NSString *)title
                        nomalColor:(UIColor *)nomal
                       heightColor:(UIColor *)heightcolor
                            target:(id)target
                            action:(SEL)action;

@end
