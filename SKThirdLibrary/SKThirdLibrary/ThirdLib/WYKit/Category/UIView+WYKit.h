//
//  UIView+WYKit.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIView (WYKit)

@property (nonatomic, assign) CGFloat cornerRad;

@property (nonatomic, assign) CGFloat Cy;

@property (nonatomic, assign) CGFloat Cx;

@property (nonatomic, assign) CGFloat X;

@property (nonatomic, assign) CGFloat Y;

@property (nonatomic, assign) CGFloat Sh;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat Sw;


/** 判断一个控件是否真正显示在主窗口 */
- (BOOL)isShowingOnKeyWindow;

/** 根据图片URL获取图片尺寸 */
+ (CGSize)getImageSizeWithURL:(id)imageURL;

/** 获取PNG图片的大小 */
+ (CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest *)request;

/** 获取GIF图片的大小 */
+ (CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest *)request;

/** 获取JPG图片的大小 */
+ (CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest *)request;

/** 获取屏幕截图 */
+ (UIImage *)screenShotWithView:(UIView *)view;

/** 添加点击手势 */
- (void)addTapGestureWithTarget:(id)target
                         action:(SEL)action;

/** 通过响应者链条获取view所在的控制器 */
- (UIViewController *)parentController;


@end
