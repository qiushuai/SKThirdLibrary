//
//  UINavigationController+FullscreenPopGesture.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UINavigationController (FullscreenPopGesture)

/** 导航栏滑动手势 */
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *rp_fullscreenPopGestureRecognizer;


/** 视图控制器能够自行控制导航条的外观,而不是全局方式
 *  注意检查 “rp_prefersNavigationBarHidden”
 *  默认为“YES”，如果不想要，请设置为NO。
 */
@property (nonatomic, assign) BOOL rp_viewControllerBasedNavigationBarAppearanceEnabled;


@end



@interface UIViewController (FullscreenPopGesture)


/** 是否禁止当前界面的导航栏的侧滑返回手势 Default NO
 *  注意：导入此 freamwork 所有导航栏都默认支持侧滑返回功能，如某一个界面不需要此功能只需将该属性设置为 YES 即可
 */
@property (nonatomic, assign) BOOL rp_interactivePopDisabled;


/** 是否隐藏当前界面的导航栏 Default NO
 *  注意：导入此 freamwork 若要实现隐藏导航栏功能，就不需要在 viewWillAppear 中设置导航栏状态了，只需要在 viewDidLoad 中将该属性设置为 YES 即可
 */
@property (nonatomic, assign) BOOL rp_prefersNavigationBarHidden;


/** 侧滑返回手势与屏幕初始距离到左边缘的距离
 *  默认为0
 */
@property (nonatomic, assign) CGFloat rp_interactivePopMaxAllowedInitialDistanceToLeftEdge;


@end
