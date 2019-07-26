//
//  CMQRCodeView.h
//  CMKit
//
//  Created by jon on 16/10/25.
//  Copyright © 2016年 jon. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 扫描二维码
 */
@interface CMQRCodeView : UIView

/*!
 @property    resultBlock
              扫描结果返回
 */

@property (nonatomic, copy) void(^resultBlock) (NSString *,BOOL isSuccess);
/*!
 @method     初始化方法
 @Param      frame view的大小
 @Param      scanBorderRect 扫描框的大小
 @Param      vc 添加视图的controller 用于显示提示框
 */
- (instancetype) initWithFrame:(CGRect)frame scanBorderRect:(CGRect)scanBorderRect viewController:(UIViewController *)vc;

- (void)start;
@end
