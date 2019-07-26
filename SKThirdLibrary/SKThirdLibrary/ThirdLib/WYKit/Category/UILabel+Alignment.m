//
//  UILabel+Alignment.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UILabel+Alignment.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Alignment)

- (void)textAlignmentLeftAndRight
{
    [self textAlignmentLeftAndRightWith:CGRectGetWidth(self.frame)];
}

- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth
{
    if (self.text == nil || self.text.length <= 1)
    {
        return;
    }
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    NSInteger length = (self.text.length-1);
    NSString *lastStr = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
    
    if ([lastStr isEqualToString:@":"] || [lastStr isEqualToString:@"："])
    {
        length = (self.text.length-2);
    }
    
    CGFloat margin = (labelWidth - size.width)/length;
    NSNumber *number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,length)];
    self.attributedText = attribute;
}

@end
