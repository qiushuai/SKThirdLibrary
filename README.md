# SKThirdLibrary
OC 实用工具，对AFNetWorking的再次封装、弹框、WebView、常见宏、时间选择器、StepSliderView、常用控件的扩展等等很多，以后会经常更新。

## SKRangeSlider

### 效果图
![图片](screenshots/SKRangeSlider.gif "SKRangeSlider")

### 示例代码
```
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
```

## SKDatePickerView
### 效果图
![图片](screenshots/SKDatePickerView.gif "SKDatePickerView")

### 示例代码

```
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
```

```
/**
 保存按钮代理方法
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"选择的时间为：%@",timer);
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

```
## 仿饿了么、京东、淘宝、美团详情页，滑动流畅。用户体验极好的效果，先给个图，稍后给个demo
### 效果图
![图片](screenshots/SKCarDetailsViewController.gif "SKCarDetailsViewController")
```
demo稍后更新
```
