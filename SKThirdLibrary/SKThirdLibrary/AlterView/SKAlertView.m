//
//  SKAlertView.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKAlertView.h"
#import "Masonry.h"

#define kTitleFont    [UIFont boldSystemFontOfSize:18]
#define kMessageFont  [UIFont systemFontOfSize:15]
static CGFloat const ButtonH = 44;
static CGFloat const margin = 10;
static NSTimeInterval const animationDuration = 0.15;
@interface SKAlertView ()

/**
 容器
 */
@property (strong, nonatomic) UIView *container;

/**
 标题
 */
@property (strong, nonatomic) UILabel *titleLabel;

/**
 内容
 */
@property (strong, nonatomic) UILabel *messageLabel;

/**
 左侧按钮
 */
@property (strong, nonatomic) UIButton *leftBtn;

/**
 右侧按钮
 */
@property (strong, nonatomic) UIButton *rightBtn;


/**
 标题文字
 */
@property (copy, nonatomic) NSString *title;

/**
 内容文字
 */
@property (copy, nonatomic) NSString *message;


/**
 左侧按钮文字
 */
@property (copy, nonatomic) NSString *leftTitle;

/**
 确认按钮文字
 */
@property (copy, nonatomic) NSString *rightTitle;


@end
@implementation SKAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message rightButtonTitle:(NSString *)rightButtonTitle leftButtonTitle:(NSString *)leftButtonTitle buttonClick:(ButtonDirectionBlock)directionBlock{
    if (self = [super init]) {
        _title = title;
        _message = message;
        _leftTitle = leftButtonTitle;
        _rightTitle = rightButtonTitle;
        self.directionBlock = directionBlock;
        [self setupUIWithTitle:title message:message];
        
    }
    return self;
}

- (instancetype)initWithSinglAndCloseTitle:(NSString *)title message:(NSString *)message ButtonTitle:(NSString *)ButtonTitle buttonClick:(ButtonDirectionBlock)directionBlock{
    //单个按钮
    if (self = [super init]) {
        _title = title;
        _message = message;
        _rightTitle = ButtonTitle;
        self.directionBlock = directionBlock;
        [self setupUIWithSinglAndCloseTitle:title message:message];
        
    }
    return self;
}

- (instancetype)initWithSinglTitle:(NSString *)title message:(NSString *)message ButtonTitle:(NSString *)ButtonTitle buttonClick:(ButtonDirectionBlock)directionBlock{
    //单个按钮，无X
    if (self = [super init]) {
        _title = title;
        _message = message;
        _rightTitle = ButtonTitle;
        self.directionBlock = directionBlock;
        [self setupUIWithSinglTitle:title message:message];
        
    }
    return self;
}

- (void)setupUIWithSinglTitle:(NSString *)title message:(NSString *)message{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    // 容器
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor whiteColor];
    container.layer.cornerRadius = 5;
    container.layer.masksToBounds = YES;
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(33);
        make.right.mas_equalTo(-33);
        make.top.mas_equalTo(KScreenWidth * 0.33);
    }];
    _container = container;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = KRGB16HEX(0x07070C);
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [container addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.top.mas_equalTo(28);
        make.height.mas_equalTo(24);
    }];
    _titleLabel = titleLabel;
    
    // 内容
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = KRGB16HEX(0x232824);
    messageLabel.numberOfLines = 0;
    [container addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(19);
    }];
    _messageLabel = messageLabel;
    [_leftBtn setHidden:YES];
    //    // 左侧按钮
    //    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [leftBtn setBackgroundImage:[UIImage imageNamed:@"rightTopClose"] forState:UIControlStateNormal];
    //    //    leftBtn.backgroundColor = [UIColor whiteColor];
    //    //    leftBtn.layer.borderWidth = 1;
    //    //    leftBtn.layer.borderColor = KRGB16HEX(0xC5C5C5).CGColor;
    //    leftBtn.layer.masksToBounds = YES;
    //    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [container addSubview:leftBtn];
    //    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.right.mas_equalTo(0);
    //        make.height.width.mas_equalTo(40);
    //    }];
    //    _leftBtn = leftBtn;
    
    // 右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:KRGB16HEX(0x232824) forState:UIControlStateNormal];
    rightBtn.backgroundColor = KRGB16HEX(0xFFB621);
    rightBtn.layer.cornerRadius = 2;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-23);
        make.left.mas_equalTo(23);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(messageLabel.mas_bottom).offset(29);
    }];
    _rightBtn = rightBtn;
}

- (void)setupUIWithSinglAndCloseTitle:(NSString *)title message:(NSString *)message{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    // 容器
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor whiteColor];
    container.layer.cornerRadius = 5;
    container.layer.masksToBounds = YES;
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(33);
        make.right.mas_equalTo(-33);
        make.top.mas_equalTo(KScreenHeight * 0.33);
    }];
    _container = container;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = KRGB16HEX(0x232824);
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [container addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.top.mas_equalTo(28);
        make.height.mas_equalTo(24);
    }];
    _titleLabel = titleLabel;
    
    // 内容
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.textColor = KRGB16HEX(0x747474);
    messageLabel.numberOfLines = 0;
    [container addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(27);
    }];
    _messageLabel = messageLabel;
    
    // 左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"rightTopClose"] forState:UIControlStateNormal];
    //    leftBtn.backgroundColor = [UIColor whiteColor];
    //    leftBtn.layer.borderWidth = 1;
    //    leftBtn.layer.borderColor = KRGB16HEX(0xC5C5C5).CGColor;
    leftBtn.layer.masksToBounds = YES;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.height.width.mas_equalTo(40);
    }];
    _leftBtn = leftBtn;
    
    // 右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor = KRGB16HEX(0xFFB621);
    rightBtn.layer.cornerRadius = 2;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-23);
        make.left.mas_equalTo(23);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-28);
    }];
    _rightBtn = rightBtn;
}

- (void)setupUIWithTitle:(NSString *)title message:(NSString *)message{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    // 容器
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor whiteColor];
    container.layer.cornerRadius = 5;
    container.layer.masksToBounds = YES;
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(33);
        make.right.mas_equalTo(-33);
        make.top.mas_equalTo(KScreenHeight * 0.33);
    }];
    _container = container;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = KRGB16HEX(0x232824);
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [container addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.top.mas_equalTo(28);
        make.height.mas_equalTo(24);
    }];
    _titleLabel = titleLabel;
    
    // 内容
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = KRGB16HEX(0x747474);
    messageLabel.numberOfLines = 0;
    [container addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(19);
    }];
    _messageLabel = messageLabel;
    
    // 左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setTitle:_leftTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:KRGB16HEX(0x232824) forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = KRGB16HEX(0xC5C5C5).CGColor;
    leftBtn.layer.cornerRadius = 2;
    leftBtn.layer.masksToBounds = YES;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(messageLabel.mas_bottom).offset(29);
    }];
    _leftBtn = leftBtn;
    
    // 右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor = KRGB16HEX(0xFFB621);
    rightBtn.layer.cornerRadius = 2;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-23);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(leftBtn.mas_centerY);
    }];
    _rightBtn = rightBtn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat containerW = KScreenWidth - 66;
    CGFloat titleW = containerW - 2 * margin;
    CGFloat titleH = [_title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil].size.height;
    CGFloat messageW = titleW;
    CGFloat messageH = [_message boundingRectWithSize:CGSizeMake(messageW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kMessageFont} context:nil].size.height;
    CGFloat containerH = titleH + messageH + ButtonH + 4 * margin + 55;
    _container.center = self.center;
    [_container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(containerH);
    }];
    _titleLabel.frame = CGRectMake(margin, margin, titleW, titleH);
    [_messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(messageH);
    }];
}

- (void)rightBtnClick{
    if (_rightTitle) { // cancelTitle 不为 nil  将ButtonIndex 传递
        if (self.directionBlock) {
            self.directionBlock(ButtonDirectionRight);
        }
    }
    [self dismiss];
}

- (void)leftBtnClick{
    if (_leftTitle) { // 左侧文字不为空
        if (self.directionBlock) {
            self.directionBlock(ButtonDirectionLeft);
        }
    }
    [self dismiss];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:animationDuration animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)setLeftTextColor:(UIColor *)leftTextColor{
    _leftTextColor = leftTextColor;
    
    [_leftBtn setTitleColor:KRGB16HEX(0x232824) forState:UIControlStateNormal];
}

- (void)setRightTextColor:(UIColor *)rightTextColor{
    _rightTextColor = rightTextColor;
    
    [_rightBtn setTitleColor:KRGB16HEX(0x232824) forState:UIControlStateNormal];
}

@end
