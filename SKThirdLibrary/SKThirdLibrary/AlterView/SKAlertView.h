//
//  SKAlertView.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ButtonDirection) {
    ButtonDirectionLeft = 0,    // 点击左侧按钮
    ButtonDirectionRight        // 点击右侧按钮
};

// 重新定义block
typedef void(^ButtonDirectionBlock)(ButtonDirection direction);
NS_ASSUME_NONNULL_BEGIN

@interface SKAlertView : UIView

/**
 两个按钮

 @param title 标题
 @param message 内容
 @param rightButtonTitle 右边按钮
 @param leftButtonTitle 左边按钮
 @param directionBlock 按钮回调
 @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message rightButtonTitle:(NSString *)rightButtonTitle leftButtonTitle:(NSString *)leftButtonTitle buttonClick:(ButtonDirectionBlock)directionBlock;


/**
 单个按钮，右上角有关闭按钮

 @param title 标题
 @param message 内容
 @param ButtonTitle 按钮文字
 @param directionBlock 回调
 @return <#return value description#>
 */
- (instancetype)initWithSinglAndCloseTitle:(NSString *)title message:(NSString *)message ButtonTitle:(NSString *)ButtonTitle buttonClick:(ButtonDirectionBlock)directionBlock;


/**
 单个按钮

 @param title 标题
 @param message 内容
 @param ButtonTitle 按钮文字
 @param directionBlock 回调
 @return <#return value description#>
 */
- (instancetype)initWithSinglTitle:(NSString *)title message:(NSString *)message ButtonTitle:(NSString *)ButtonTitle buttonClick:(ButtonDirectionBlock)directionBlock;

- (void)show;

/**
 按钮点击block, 回调方向
 */
@property (copy, nonatomic) ButtonDirectionBlock directionBlock;

/**
 左侧按钮颜色 默认 橙色
 */
@property (strong, nonatomic) UIColor *leftTextColor;

/**
 右侧按钮颜色 默认 黑色
 */
@property (strong, nonatomic) UIColor *rightTextColor;
@end

NS_ASSUME_NONNULL_END
