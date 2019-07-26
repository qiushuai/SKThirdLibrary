//
//  UIView+CollapsibleConstraints.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UIView+CollapsibleConstraints.h"
#import <objc/runtime.h>

@implementation NSLayoutConstraint (_RPOriginalConstantStorage)

- (void)setRp_originalConstant:(CGFloat)originalConstant
{
    objc_setAssociatedObject(self, @selector(rp_originalConstant), @(originalConstant), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)rp_originalConstant
{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

@end

@implementation UIView (CollapsibleConstraints)

+ (void)load
{
    SEL originalSelector = @selector(setValue:forKey:);
    SEL swizzledSelector = @selector(rp_setValue:forKey:);

    Class class = UIView.class;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)rp_setValue:(id)value forKey:(NSString *)key
{
    NSString *injectedKey = [NSString stringWithUTF8String:sel_getName(@selector(rp_collapsibleConstraints))];
    if ([key isEqualToString:injectedKey]) {
        self.rp_collapsibleConstraints = value;
    } else {
        [self rp_setValue:value forKey:key];
    }
}

- (void)setRp_collapsed:(BOOL)collapsed
{
    [self.rp_collapsibleConstraints enumerateObjectsUsingBlock:
     ^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
         if (collapsed) {
             constraint.constant = 0;
         } else {
             constraint.constant = constraint.rp_originalConstant;
         } 
     }];

    objc_setAssociatedObject(self, @selector(rp_collapsed), @(collapsed), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)rp_collapsed
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (NSMutableArray *)rp_collapsibleConstraints
{
    NSMutableArray *constraints = objc_getAssociatedObject(self, _cmd);
    if (!constraints) {
        constraints = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, constraints, OBJC_ASSOCIATION_RETAIN);
    }
    return constraints;
}

- (void)setRp_collapsibleConstraints:(NSArray *)rp_collapsibleConstraints
{
    NSMutableArray *constraints = (NSMutableArray *)self.rp_collapsibleConstraints;
    [rp_collapsibleConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        constraint.rp_originalConstant = constraint.constant;
        [constraints addObject:constraint];
    }];
}

@end

@implementation UIView (AutomaticallyCollapseByIntrinsicContentSize)

+ (void)load
{
    SEL originalSelector = @selector(updateConstraints);
    SEL swizzledSelector = @selector(rp_updateConstraints);
    
    Class class = UIView.class;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)rp_updateConstraints
{
    [self rp_updateConstraints];
 
    if (self.rp_autoCollapse && self.rp_collapsibleConstraints.count > 0) {
        
        const CGSize absentIntrinsicContentSize = CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
        const CGSize contentSize = [self intrinsicContentSize];
        
        if (CGSizeEqualToSize(contentSize, absentIntrinsicContentSize) ||
            CGSizeEqualToSize(contentSize, CGSizeZero)) {
            self.rp_collapsed = YES;
        } else {
            self.rp_collapsed = NO;
        }
    }
}

- (BOOL)rp_autoCollapse
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setRp_autoCollapse:(BOOL)autoCollapse
{
    objc_setAssociatedObject(self, @selector(rp_autoCollapse), @(autoCollapse), OBJC_ASSOCIATION_RETAIN);
}

- (void)setAutoCollapse:(BOOL)collapse
{
    self.rp_autoCollapse = collapse;
}

@end
