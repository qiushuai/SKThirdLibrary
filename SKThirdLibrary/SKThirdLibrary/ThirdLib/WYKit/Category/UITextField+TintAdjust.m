//
//  UITextField+TintAdjust.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UITextField+TintAdjust.h"
#import <objc/runtime.h>

static NSString *adjust = @"adjust";
@implementation UITextField (TintAdjust)



-(void)setTintAjust:(CGFloat )tintAjust{
    
    objc_setAssociatedObject(self, &adjust, @(tintAjust), OBJC_ASSOCIATION_ASSIGN);
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(tintAjust,0,tintAjust,self.frame.size.height)];
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}
-(CGFloat)tintAjust{
    
    
    id  value = objc_getAssociatedObject(self, &adjust);
    return  [value floatValue ];
}



@end
