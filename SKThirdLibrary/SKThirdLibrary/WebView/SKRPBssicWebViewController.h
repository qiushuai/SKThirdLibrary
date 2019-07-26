//
//  SKRPBssicWebViewController.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKRPBssicWebViewController;
NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshWebViewController)(SKRPBssicWebViewController *ctlvc);
@interface SKRPBssicWebViewController : UIViewController

/** 初始化方法 */
- (instancetype)init;
+ (instancetype)webViewControl;


/** 网址链接 或 html标签 */
@property (nonatomic, strong) NSString *htmlString;

/** 网页初始标题 default 详情 */
@property (nonatomic, strong) NSString *webTitle;

/** 是否跟随网页更改标题名称 default:NO */
@property (nonatomic, assign) BOOL isFollowChange;

/** 是否开启自适应屏幕 default:YES */
@property (nonatomic, assign) BOOL isAutoScreen;

/** 是否显示自定义的 404 界面 default:YES */
@property (nonatomic, assign) BOOL isShow;

- (void)didRefresh:(refreshWebViewController)handler;

@end

NS_ASSUME_NONNULL_END
