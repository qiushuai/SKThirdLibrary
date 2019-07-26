//
//  SKBssicWebErrorView.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKBssicWebErrorView : UIView
/** 配置 404 界面 */
- (void)configErrorHtml:(nonnull NSString *)html;
@end

NS_ASSUME_NONNULL_END
