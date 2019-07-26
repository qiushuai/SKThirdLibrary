//
//  UITableView+MasonryAutoCellHeight.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UITableView (MasonryAutoCellHeight)


/** 基于identifier 自动计算Cell高度 */
- (CGFloat)cellHeightWithIdentifier:(NSString *_Nullable)identifier
                      configuration:(void(^_Nullable)(UITableViewCell * _Nullable autoCell))configuration;

/** 基于identifier 和 cacheKey 双重绑定自动计算Cell高度  */
- (CGFloat)cellHeightWithIdentifier:(NSString *_Nullable)identifier
                         cacheByKey:(NSString *_Nullable)key
                      configuration:(void(^_Nullable)(UITableViewCell *_Nullable autoCell))configuration;

/** 基于identifier 和 indexPath 双重绑定自动计算Cell高度  */
- (CGFloat)cellHeightWithIdentifier:(NSString *_Nullable)identifier
                   cacheByIndexPath:(NSIndexPath *_Nullable)indexPath
                      configuration:(void(^_Nullable)(UITableViewCell *_Nullable autoCell))configuration;

/** 对指定key的cell更新高度为height */
- (void)uploadcCacheHeight:(CGFloat)height byKey:(NSString *_Nullable)key;


/** 对指定indexPath的cell更新高度为height */
- (void)uploadcCacheHeight:(CGFloat)height
               byIndexPath:(NSIndexPath *_Nullable)indexPath;

/** 根据indexPath获取cell缓存高度 */
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *_Nullable)indexPath;

/** 根据IndexPath获取Cell高度 */
- (CGFloat)getCellHeightWithIndexPath:(NSIndexPath *_Nullable)indexPath;

/**
 当你不想通过删除缓存中的高度来刷新数据源重新计算时，可以调用这个方法。
 该方法中用过runtime重写了tableView中修改cell的一些方法，例如插入cell，删除cell，移动cell，以及reloadData方法。
 */
- (void)reloadDataWithoutInvalidateIndexPathHeightCache;




/** tableView 注册Cell */
- (void)registerCell:(nullable Class)cell;


/** tableView 注册多个Cell */
- (void)registerCells:(NSArray <__kindof Class> *_Nullable)cells;



@end
