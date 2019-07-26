//
//  UIView+CollapsibleConstraints.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIView (CollapsibleConstraints)

/// Assigning this property immediately disables the view's collapsible constraints'
/// by setting their constants to zero.
@property (nonatomic, assign) BOOL rp_collapsed;

/// Specify constraints to be affected by "rp_collapsed" property by connecting in
/// Interface Builder.
@property (nonatomic, copy) IBOutletCollection(NSLayoutConstraint) NSArray *rp_collapsibleConstraints;

@end

@interface UIView (AutomaticallyCollapseByIntrinsicContentSize)

/// Enable to automatically collapse constraints in "rp_collapsibleConstraints" when
/// you set or indirectly set this view's "intrinsicContentSize" to {0, 0} or absent.
///
/// For example:
///  imageView.image = nil;
///  label.text = nil, label.text = @"";
///
/// "NO" by default, you may enable it by codes.
@property (nonatomic, assign) BOOL rp_autoCollapse;

/// "IBInspectable" property, more friendly to Interface Builder.
/// You gonna find this attribute in "Attribute Inspector", toggle "On" to enable.
/// Why not a "rp_" prefix? Xcode Attribute Inspector will clip it like a shit.
/// You should not assgin this property directly by code, use "rp_autoCollapse" instead.
@property (nonatomic, assign, getter=rp_autoCollapse) IBInspectable BOOL autoCollapse;

@end
