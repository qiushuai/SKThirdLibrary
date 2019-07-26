//
//  UITableViewCell+Reusable.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Reusable)


/** 快速注册一个可复用的Cell  不适用于Cell自动算高 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


/** 快速注册一个 适用于Cell自动算高 的Cell */
+ (instancetype)cellWithAutoTableView:(UITableView *)tableView;







/** 取得Cell所在的TableView */
@property (nonatomic, copy, readonly) UITableView *tableView;

/** 取得Cell所在的indexPath */
@property (nonatomic, copy, readonly) NSIndexPath *cellIndexPath;



/** 分割线是否延伸到两端 默认NO */
@property (nonatomic, assign) BOOL seperatorPinToSupperviewMargins;

/** 是否关闭Cell点击高亮状态 默认NO */
@property (nonatomic, assign) BOOL selectionStyleNone;






/**
 获取Cell的唯一标识符identifier
 注意：此方法只能通过 [tableView registerCell:cell] 注册后才能获取到正确的identifier
 */
@property (nonatomic, copy, readonly) NSString *identifier;


/**
 获取Cell的唯一标识符identifier
 注意：此方法只能通过 [tableView registerCell:cell] 注册后才能获取到正确的identifier
 */
+ (NSString *)getIdentifier;

@end
