//
//  HWTFCursorView.h
//  CodeTextDemo
//
//  Created by 侯万 on 2018/12/13.
//  Copyright © 2018 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HWTFCursorView;
@protocol HWTFCursorViewDelegate <NSObject>

@optional;
/**
 编辑结束d时调用
 
 @param textField textField
 */
- ( void )textFieldDidEndEditing:(UITextField * _Nullable)textField;

@end

/**
 基础版 - 下划线 - 有光标
 */
@interface HWTFCursorView : UIView


// ----------------------------Data----------------------------
/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;
@property (nonatomic, weak) id<HWTFCursorViewDelegate> myDelegate;

// ----------------------------Method----------------------------

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


@end




// ------------------------------------------------------------------------
// -----------------------------HWCursorLabel------------------------------
// ------------------------------------------------------------------------


@interface HWCursorLabel : UILabel

@property (nonatomic, weak, readonly) UIView *cursorView;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
