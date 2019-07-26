//
//  SKYYTextField.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/25.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKYYTextField.h"
@interface SKYYTextField()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL isLeft;
@end
@implementation SKYYTextField

- (void)configCellModel:(NSString *)placeholderString isLine:(BOOL) isLine isLeft:(BOOL) isLeft{
    self.delegate = self;
    self.isLeft = isLeft;
    self.borderStyle = 0;
    self.placeholder = placeholderString;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self setValue:KRGB16HEX(0xe0e0e0) forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.tintColor = KRGB16HEX(0xFFB621);
    if(isLine) self.line.backgroundColor = KRGB16HEX(0xe0e0e0);
    if(self.isLeft) self.textAlignment = NSTextAlignmentRight;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return true;
}

- ( void )textFieldDidEndEditing:( SKYYTextField *)textField{
    if ([self.myDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.myDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(SKYYTextField * )textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.myDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return  [self.myDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

-(UIView *)line{
    if(!_line){
        _line = [[UIView alloc] init];
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(1);
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
        }];
    }
    return _line;
}


@end
