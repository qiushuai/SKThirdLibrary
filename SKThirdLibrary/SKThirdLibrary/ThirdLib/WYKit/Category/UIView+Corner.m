//
//  UIView+Corner.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UIView+Corner.h"
#import <objc/runtime.h>

static NSString * const WYCornerPositionKey = @"__WYCornerPositionKey";
static NSString * const WYCornerRadiusKey = @"__WYCornerRadiusKey";
@implementation UIView (Corner)

@dynamic wy_cornerPosition;
- (WYCornerPosition)wy_cornerPosition
{
    return [objc_getAssociatedObject(self, &WYCornerPositionKey) integerValue];
}

- (void)setWy_cornerPosition:(WYCornerPosition)wy_cornerPosition
{
    objc_setAssociatedObject(self, &WYCornerPositionKey, @(wy_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic wy_cornerRadius;
- (CGFloat)wy_cornerRadius
{
    return [objc_getAssociatedObject(self, &WYCornerRadiusKey) floatValue];
}

- (void)setWy_cornerRadius:(CGFloat)wy_cornerRadius
{
    objc_setAssociatedObject(self, &WYCornerRadiusKey, @(wy_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    SEL ori = @selector(layoutSublayersOfLayer:);
    SEL new = NSSelectorFromString([@"hh_" stringByAppendingString:NSStringFromSelector(ori)]);
    hh_swizzle(self, ori, new);
}

void hh_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)hh_layoutSublayersOfLayer:(CALayer *)layer
{
    [self hh_layoutSublayersOfLayer:layer];
    
    if (self.wy_cornerRadius > 0) {
        
        UIBezierPath *maskPath;
        switch (self.wy_cornerPosition) {
            case WYCornerPositionBottomRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionTopLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionBottomLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionTopRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionTop:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionBottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
            case WYCornerPositionAll:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.wy_cornerRadius, self.wy_cornerRadius)];
                break;
        }
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)setCornerOnTopWithRadius:(CGFloat)radius
{
    self.wy_cornerPosition = WYCornerPositionTopLeft;
    self.wy_cornerRadius = radius;
}

- (void)setCornerOnLeftWithRadius:(CGFloat)radius
{
    self.wy_cornerPosition = WYCornerPositionBottomLeft;
    self.wy_cornerRadius = radius;
}

- (void)setCornerOnBottomWithRadius:(CGFloat)radius
{
    self.wy_cornerPosition = WYCornerPositionBottomRight;
    self.wy_cornerRadius = radius;
}

- (void)setCornerOnRightWithRadius:(CGFloat)radius
{
    self.wy_cornerPosition = WYCornerPositionTopRight;
    self.wy_cornerRadius = radius;
}

- (void)setAllCornerWithCornerRadius:(CGFloat)radius
{
    self.wy_cornerPosition = WYCornerPositionAll;
    self.wy_cornerRadius = radius;
}

- (void)setNoneCorner
{
    self.layer.mask = nil;
}

@end
