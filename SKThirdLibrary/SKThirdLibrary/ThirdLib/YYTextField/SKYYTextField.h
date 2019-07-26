//
//  SKYYTextField.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/25.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKYYTextField;
@protocol SKYYTextFieldDelegate <NSObject>

@optional;
/**
 编辑结束d时调用

 @param textField textField
 */
- ( void )textFieldDidEndEditing:(SKYYTextField * _Nullable)textField;

- (BOOL)textField:(SKYYTextField * _Nullable)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString * _Nullable)string;


@end
NS_ASSUME_NONNULL_BEGIN


@interface SKYYTextField : UITextField
@property (nonatomic, weak) id<SKYYTextFieldDelegate> myDelegate;
- (void)configCellModel:(NSString *)placeholderString isLine:(BOOL) isLine isLeft:(BOOL) isLeft;
@end

NS_ASSUME_NONNULL_END
