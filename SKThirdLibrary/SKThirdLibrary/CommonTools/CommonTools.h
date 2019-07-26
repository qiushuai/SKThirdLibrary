//
//  CommonTools.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonTools : NSObject

/**
 验证码倒计时
 
 @param sender 验证码按钮
 */
+ (void)getVerifyCode:(UIButton *)sender;


/**
 手机号z验证
 
 @param mobile 手机号
 @return true 合法，fales 不合法
 */
+ (BOOL)valiMobile:(NSString *)mobile;

/**
 UIView转Image
 
 @param view UIView
 @return UIImage
 */
+ (UIImage*) imageWithUIView:(UIView*) view;


/**
 获取当前时间戳

 @return 时间戳，秒
 */
+(NSString *)getNowTimeTimestamp;


/**
 时间戳转换成日期格式

 @param timeStr 时间戳
 @return 时间
 */
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;


/**
 是否有相机权限
 */
+(void)isPermissions;

@end

NS_ASSUME_NONNULL_END
