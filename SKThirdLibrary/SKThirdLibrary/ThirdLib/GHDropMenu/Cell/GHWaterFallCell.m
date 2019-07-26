//
//  GHWaterFallCell.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHWaterFallCell.h"
#import "GHWaterFallLabel.h"
#import "UIView+Extension.h"

@interface GHWaterFallCell()
@property (nonatomic , strong) GHWaterFallLabel *waterFallLabel;
@property (nonatomic , strong) NSMutableArray *dataArray ;
//@property (nonatomic, copy) GHWaterFallResult result;//2
@end
@implementation GHWaterFallCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        if (self.dataArray == nil) {
            self.dataArray = [NSMutableArray array];
            self.dataArray = [[NSMutableArray alloc] initWithObjects:@"租约即将到期",@"在厅车辆为0",@"已撤场", nil];
        }
//        CGFloat height = [self.waterFallLabel getHeightWithArray:self.dataArray];
//        [self getHeight:height];
    }
    return self;
}

//- (void)getCellHeight:(GHWaterFallResult)handler{
//    self.result = handler;
//}
//
//- (void)getHeight:(CGFloat)height{
//    !self.result ?: self.result(self,height);
//}

- (CGFloat)getCellHeight {
    CGFloat height = [self.waterFallLabel getHeightWithArray:self.dataArray];
    return height;
}
- (void)setupUI {
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.waterFallLabel];
}

- (GHWaterFallLabel *)waterFallLabel {
    if (_waterFallLabel == nil) {
        _waterFallLabel = [[GHWaterFallLabel alloc]init];
        [_waterFallLabel setPoint:CGPointMake(0, 0)];
        
        _waterFallLabel.tags =self.dataArray;
        _waterFallLabel.isMultiple = YES;
        _waterFallLabel.heightBlock = ^(CGFloat height) {

        };
        _waterFallLabel.textBlock = ^(GHWaterFallLabel * _Nonnull waterFallLabel, NSString * _Nonnull text, NSInteger index) {
            
        };

    }
    return _waterFallLabel;
}
@end
