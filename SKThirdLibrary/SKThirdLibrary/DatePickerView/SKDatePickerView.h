//
//  SKDatePickerView.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/12.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKDatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString * _Nullable)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SKDatePickerView : UIView
@property (copy, nonatomic) NSString *title;

/// 是否自动滑动 默认YES
@property (assign, nonatomic) BOOL isSlide;

/// 选中的时间， 默认是当前时间
@property (copy, nonatomic) NSString *date;

/// 分钟间隔 默认5分钟
@property (assign, nonatomic) NSInteger minuteInterval;

@property (weak, nonatomic) id <SKDatePickerViewDelegate> delegate;

//--判断从哪里进来的，用来控制时间选择器的样式和返回数据
@property (nonatomic,strong)NSString *isType;
//返回的行数，年，月，日，时，分
@property (nonatomic,assign)NSInteger number;
/**
 显示  必须调用
 */
- (void)show;
@end

NS_ASSUME_NONNULL_END
