//
//  ViewController.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/12.
//  Copyright © 2019 王三坤. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG

/*
 各种控件的用法，依赖Masonry的自动布局
 */

#import "ViewController.h"
#import "SKCommonMacros.h"//常见的宏
#import "SKRangeSlider.h" //滑块
#import "SKDatePickerView.h"//时间选择器

@interface ViewController ()<SKRangeSliderDelegate,SKDatePickerViewDelegate>
//滑块
@property (nonatomic, strong) SKRangeSlider *rangeSlider;
//时间选择器
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic , strong) SKDatePickerView *dateView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self rangeSlider];
    [self.chooseBtn setTitle:@"时间选择器" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

-(void)rangeSlider:(SKRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    if (sender == self.rangeSlider) {
        [WYPromptManager showBottomWithText:[NSString stringWithFormat:@"Currency slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum]];
        NSLog(@"Currency slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
    }
}

/**
 保存按钮代理方法
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"选择的时间为：%@",timer);
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight - KNaviHeight);
    }];
    SKAlertView *alert = [[SKAlertView alloc] initWithTitle:@"选择时间" message:[NSString stringWithFormat:@"选择的时间为：%@",timer] rightButtonTitle:@"好的" leftButtonTitle:@"取消" buttonClick:^(ButtonDirection direction) {
        switch (direction) {
            case ButtonDirectionRight:{
                [self dismissViewControllerAnimated:YES completion:nil];
                //去设置
                CGFloat kSystemMainVersion = [UIDevice currentDevice].systemVersion.floatValue;
                if (kSystemMainVersion >= 8.0) { // ios8 以后支持跳转到设置
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                        //                            [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }break;
            case ButtonDirectionLeft:{
                [self dismissViewControllerAnimated:YES completion:nil];
            }break;
            default:break;
        }
        
    }];
    [alert show];
}

/** 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消选择时间");
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight - KNaviHeight);
    }];
}

-(void)showDataPicker{
    self.dateView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [self.dateView show];
}

-(SKRangeSlider *)rangeSlider{
    if(!_rangeSlider){
        _rangeSlider = [[SKRangeSlider alloc] init];
        NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
        _rangeSlider.numberFormatterOverride = customFormatter;
        _rangeSlider.enableStep = YES;//是否启用间隔，默认为NO
        _rangeSlider.hideLabels = YES;//是否隐藏文字
        _rangeSlider.lineHeight = 4;//线的宽度
        _rangeSlider.handleImage = [UIImage imageNamed:@"sliptYuan"];//滑块的背景图
        _rangeSlider.tintColorBetweenHandles = KRGB16HEX(0xFFB621);//未滑动的线条颜色
        _rangeSlider.lineBorderWidth = 1;
        _rangeSlider.lineBorderColor = KRGB16HEX(0xF5F5F5);
        _rangeSlider.minValue = 0;//最小值
        _rangeSlider.step = 10;//间隔
        _rangeSlider.maxValue = 100;//最大值
        _rangeSlider.selectedMinimum = 0;//默认选中的最小值
        _rangeSlider.selectedMaximum = 100;//默认选中的最大值
        _rangeSlider.delegate = self;
        [self.view addSubview:_rangeSlider];
        [_rangeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(30);
        }];
    }
    return _rangeSlider;
}

-(UIButton *)chooseBtn{
    if(!_chooseBtn){
        _chooseBtn = [[UIButton alloc] init];
        [_chooseBtn setTitleColor:KRGB16HEX(0x000000) forState:UIControlStateNormal];
        _chooseBtn.layer.borderWidth = 1;
        _chooseBtn.layer.borderColor = KRGB16HEX(0x000000).CGColor;
        [_chooseBtn addTarget:self action:@selector(showDataPicker) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(45);
            make.center.mas_equalTo(0);
//            make.top.mas_equalTo(self.rangeSlider.mas_bottom).offset(20);
        }];
    }
    return _chooseBtn;
}

-(SKDatePickerView *)dateView{
    if(!_dateView){
        _dateView = [[SKDatePickerView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight)];
        _dateView.delegate = self;
        _dateView.title = @"请选择时间";
        _dateView.number = 5;
        [self.view addSubview:_dateView];
    }
    return _dateView;
}

@end
