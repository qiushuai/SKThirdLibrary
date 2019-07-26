//
//  SKBssicWebErrorView.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKBssicWebErrorView.h"

@interface SKBssicWebErrorView ()
@property (nonatomic, strong) UIImageView *errorImage;
@property (nonatomic, strong) UILabel *errorLb;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *subTitleLb;
@property (nonatomic, strong) UILabel *proposeLb;
@property (nonatomic, strong) UIView *htmlView;
@property (nonatomic, strong) UILabel *htmlLb;
@property (nonatomic, strong) UILabel *methodLb;
@end

@implementation SKBssicWebErrorView

- (void)configErrorHtml:(NSString *)html {
    
    self.backgroundColor = KRGB16HEX(0xf3f3f3);
    self.errorImage.image = [UIImage imageNamed:@"web_error"];
    self.errorLb.text = @"请输入正确的链接";
    self.titleLb.text = [NSString stringWithFormat:@"%@无法访问该链接", [NSString getAppName]];
    self.subTitleLb.text = @"或者非网页类型";
    self.proposeLb.text = @"请发布正确的商品，活动或网页链接再试";
    self.htmlView.backgroundColor = KRGB16HEX(0xdcdcdc);
    self.htmlLb.text = html;
    self.methodLb.text = @"如仍需浏览，请长按网址复制后使用浏览器访问";
}



#pragma mark - Lazy
- (UIImageView *)errorImage {
    if (!_errorImage) {
        _errorImage = [[UIImageView alloc] init];
        [self addSubview:_errorImage];
        [_errorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.mas_equalTo(45);
            make.size.mas_equalTo(CGSizeMake(99, 86));
        }];
    }
    return _errorImage;
}

- (UILabel *)errorLb {
    if (!_errorLb) {
        _errorLb = [[UILabel alloc] init];
        _errorLb.textColor = KRGB16HEX(0x8a8a8a);
        _errorLb.font = [UIFont boldSystemFontOfSize:KFontSize(13)];
        [self addSubview:_errorLb];
        [_errorLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.errorImage.mas_bottom).offset(18);
            make.width.height.mas_greaterThanOrEqualTo(10);
        }];
    }
    return _errorLb;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = KRGB16HEX(0xc6c6c6);
        _titleLb.font = [UIFont systemFontOfSize:KFontSize(12)];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.errorLb.mas_bottom).offset(13);
            make.width.height.mas_greaterThanOrEqualTo(10);
        }];
    }
    return _titleLb;
}

- (UILabel *)subTitleLb {
    if (!_subTitleLb) {
        _subTitleLb = [[UILabel alloc] init];
        _subTitleLb.textColor = KRGB16HEX(0x8a8a8a);
        _subTitleLb.font = [UIFont systemFontOfSize:KFontSize(12)];
        [self addSubview:_subTitleLb];
        [_subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.titleLb.mas_bottom).offset(10);
            make.width.height.mas_greaterThanOrEqualTo(10);
        }];
    }
    return _subTitleLb;
}

- (UILabel *)proposeLb {
    if (!_proposeLb) {
        _proposeLb = [[UILabel alloc] init];
        _proposeLb.textColor = KRGB16HEX(0x8a8a8a);
        _proposeLb.font = [UIFont systemFontOfSize:KFontSize(12)];
        [self addSubview:_proposeLb];
        [_proposeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.mas_equalTo(-235);
            make.width.height.mas_greaterThanOrEqualTo(10);
        }];
    }
    return _proposeLb;
}

- (UIView *)htmlView {
    if (!_htmlView) {
        _htmlView = [[UIView alloc] init];
        _htmlView.cornerRad = 15;
        [self addSubview:_htmlView];
        [_htmlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.proposeLb.mas_bottom).offset(10);
            make.left.mas_equalTo(50);
            make.width.mas_equalTo(KRealWidth6(270));
            make.height.mas_equalTo(30);
        }];
    }
    return _htmlView;
}

- (UILabel *)htmlLb {
    if (!_htmlLb) {
        _htmlLb = [[UILabel alloc] init];
        _htmlLb.textColor = KRGB16HEX(0x282828);
        _htmlLb.font = [UIFont systemFontOfSize:KFontSize(13)];
        _htmlLb.isCopyable = YES;
        _htmlLb.textAlignment = NSTextAlignmentCenter;
        [self.htmlView addSubview:_htmlLb];
        [_htmlLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(25);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _htmlLb;
}

- (UILabel *)methodLb {
    if (!_methodLb) {
        _methodLb = [[UILabel alloc] init];
        _methodLb.textColor = KRGB16HEX(0x8a8a8a);
        _methodLb.font = [UIFont systemFontOfSize:KFontSize(13)];
        _methodLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_methodLb];
        [_methodLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.htmlView.mas_bottom).offset(10);
            make.width.height.mas_greaterThanOrEqualTo(10);
        }];
    }
    return _methodLb;
}

@end
