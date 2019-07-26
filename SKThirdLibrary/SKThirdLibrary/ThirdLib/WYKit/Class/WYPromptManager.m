

#import "WYPromptManager.h"

//PromptManager默认停留时间
#define PromptDispalyDuration 1.2f
//PromptManager到顶端/底端默认距离
#define PromptSpace (80.0f + UIApplication.sharedApplication.statusBarFrame.size.height)
//PromptManager背景颜色
#define PromptBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@interface WYPromptManager ()
@property (nonatomic, strong) UIButton *contentView;
@property (nonatomic, assign) CGFloat duration;
@end

@implementation WYPromptManager

- (id)initWithText:(NSString *)text {
    if (self = [super init]) {
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect = [text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.backgroundColor = PromptBackgroundColor;
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.0f;
        self.duration = PromptDispalyDuration;
    }
    return self;
}

- (void)dismissPromptManager {
    [self.contentView removeFromSuperview];
}

- (void)toastTaped:(UIButton *)sender {
    [self hideAnimation];
}

- (void)showAnimation {
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

- (void)hideAnimation {
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissPromptManager)];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

+ (UIWindow *)window {
    UIWindow *window =  [[[UIApplication sharedApplication] windows] lastObject];
    if(window && !window.hidden) return window;
    window = [UIApplication sharedApplication].delegate.window;
    return window;
}

- (void)showIn:(UIView *)view {
    self.contentView.center = view.center;
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showIn:(UIView *)view fromTopOffset:(CGFloat)top {
    self.contentView.center = CGPointMake(view.center.x, top + self.contentView.frame.size.height/2);
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showIn:(UIView *)view fromBottomOffset:(CGFloat)bottom {
    self.contentView.center = CGPointMake(view.center.x, view.frame.size.height-(bottom + self.contentView.frame.size.height/2));
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text {
    [WYPromptManager showCenterWithText:text
                               duration:PromptDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration {
    WYPromptManager *toast = [[WYPromptManager alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window]];
}

#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text {
    [WYPromptManager showTopWithText:text
                           topOffset:PromptSpace
                            duration:PromptDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration {
     [WYPromptManager showTopWithText:text
                            topOffset:PromptSpace duration:duration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset {
    [WYPromptManager showTopWithText:text
                           topOffset:topOffset
                            duration:PromptDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    WYPromptManager *toast = [[WYPromptManager alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromTopOffset:topOffset];
}

#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text {
    [WYPromptManager showBottomWithText:text
                           bottomOffset:PromptSpace
                               duration:PromptDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration {
      [WYPromptManager showBottomWithText:text
                             bottomOffset:PromptSpace
                                 duration:duration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [WYPromptManager showBottomWithText:text
                           bottomOffset:bottomOffset
                               duration:PromptDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration {
    WYPromptManager *toast = [[WYPromptManager alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromBottomOffset:bottomOffset];
}

@end


@implementation UIView (WYPromptManager)

#pragma mark-中间显示
- (void)showPromptCenterWithText:(NSString *)text {
    [self showPromptCenterWithText:text
                          duration:PromptDispalyDuration];
}

- (void)showPromptCenterWithText:(NSString *)text duration:(CGFloat)duration {
    WYPromptManager *toast = [[WYPromptManager alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self];
}

#pragma mark-上方显示
- (void)showPromptTopWithText:(NSString *)text {
    [self showPromptTopWithText:text
                       topOffset:PromptSpace
                        duration:PromptDispalyDuration];
}

- (void)showPromptTopWithText:(NSString *)text duration:(CGFloat)duration {
    [self showPromptTopWithText:text
                       topOffset:PromptSpace
                        duration:duration];
}

- (void)showPromptTopWithText:(NSString *)text topOffset:(CGFloat)topOffset {
    [self showPromptTopWithText:text
                       topOffset:topOffset
                        duration:PromptDispalyDuration];
}

- (void)showPromptTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration {
    WYPromptManager *toast = [[WYPromptManager alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromTopOffset:topOffset];
}

#pragma mark-下方显示
- (void)showPromptBottomWithText:(NSString *)text {
    [self showPromptBottomWithText:text
                       bottomOffset:PromptSpace
                           duration:PromptDispalyDuration];
}

- (void)showPromptBottomWithText:(NSString *)text duration:(CGFloat)duration {
    [self showPromptBottomWithText:text
                       bottomOffset:PromptSpace
                           duration:duration];
}

- (void)showPromptBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset {
    [self showPromptBottomWithText:text
                       bottomOffset:bottomOffset
                           duration:PromptDispalyDuration];
}

- (void)showPromptBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration {
    WYPromptManager *toast = [[WYPromptManager alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromBottomOffset:bottomOffset];
}

@end
