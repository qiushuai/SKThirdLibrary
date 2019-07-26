
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface WYPromptManager : NSObject

/** 中间显示 */
+ (void)showCenterWithText:(NSString *)text;

/** 中间显示+自定义停留时间 */
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;



/** 上方显示 */
+ (void)showTopWithText:(NSString *)text;

/** 上方显示+自定义停留时间 */
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;

/** 上方显示+自定义距顶端距离 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;

/** 上方显示+自定义距顶端距离+自定义停留时间 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

/** 下方显示 */
+ (void)showBottomWithText:(NSString *)text;

/** 下方显示+自定义停留时间 */
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration;

/** 下方显示+自定义距底端距离 */
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;

/** 下方显示+自定义距底端距离+自定义停留时间 */
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;

@end



@interface UIView (WYPromptManager)

/** 中间显示 */
- (void)showPromptCenterWithText:(NSString *)text;

/** 中间显示+自定义停留时间 */
- (void)showPromptCenterWithText:(NSString *)text duration:(CGFloat)duration;



/** 上方显示 */
- (void)showPromptTopWithText:(NSString *)text;

/** 上方显示+自定义停留时间 */
- (void)showPromptTopWithText:(NSString *)text duration:(CGFloat)duration;

/** 上方显示+自定义距顶端距离 */
- (void)showPromptTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;

/** 上方显示+自定义距顶端距离+自定义停留时间 */
- (void)showPromptTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;



/** 下方显示 */
- (void)showPromptBottomWithText:(NSString *)text;

/** 下方显示+自定义停留时间 */
- (void)showPromptBottomWithText:(NSString *)text duration:(CGFloat)duration;

/** 下方显示+自定义距底端距离 */
- (void)showPromptBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;

/** 下方显示+自定义距底端距离+自定义停留时间 */
- (void)showPromptBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;

@end
