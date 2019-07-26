//
//  UITableView+MasonryAutoCellHeight.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UITableView+MasonryAutoCellHeight.h"
#if __has_include(<UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>)
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#else
#import "UITableView+FDTemplateLayoutCell.h"
#endif


@implementation UITableView (MasonryAutoCellHeight)


- (CGFloat)cellHeightWithIdentifier:(NSString *)identifier
                      configuration:(void (^)(UITableViewCell * _Nullable))configuration
{
    return [self fd_heightForCellWithIdentifier:identifier
                                  configuration:configuration];
}

- (CGFloat)cellHeightWithIdentifier:(NSString *)identifier
                   cacheByIndexPath:(NSIndexPath *)indexPath
                      configuration:(void (^)(UITableViewCell * _Nullable))configuration
{
    return [self fd_heightForCellWithIdentifier:identifier
                               cacheByIndexPath:indexPath
                                  configuration:configuration];
}

- (CGFloat)cellHeightWithIdentifier:(NSString *)identifier
                         cacheByKey:(NSString *)key
                      configuration:(void (^)(UITableViewCell * _Nullable))configuration
{
    return [self fd_heightForCellWithIdentifier:identifier
                                     cacheByKey:key
                                  configuration:configuration];
}

- (void)reloadDataWithoutInvalidateIndexPathHeightCache
{
    [self fd_reloadDataWithoutInvalidateIndexPathHeightCache];
}

- (void)uploadcCacheHeight:(CGFloat)height
               byIndexPath:(NSIndexPath *)indexPath
{
    [self.fd_indexPathHeightCache cacheHeight:height
                                  byIndexPath:indexPath];
}

- (void)uploadcCacheHeight:(CGFloat)height
                     byKey:(NSString *)key
{
    [self.fd_keyedHeightCache cacheHeight:height
                                    byKey:key];
}
-  (CGFloat)getCellHeightWithIndexPath:(NSIndexPath * _Nullable)indexPath
{
    return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *_Nullable)indexPath
{
    return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
}

- (void)registerCell:(Class)cell
{
    NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cell.class) ofType:@"nib"];
    if (path.length) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cell.class)];
    } else {
        [self registerClass:[cell class] forCellReuseIdentifier:NSStringFromClass(cell.class)];
    }
}


- (void)registerCells:(NSArray<__kindof Class> *)cells
{
    if (!cells.count) {
        return;
    }
    
    for (Class cell in cells)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cell.class) ofType:@"nib"];
        if (path.length) {
            [self registerNib:[UINib nibWithNibName:NSStringFromClass(cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cell.class)];
        } else {
            [self registerClass:[cell class] forCellReuseIdentifier:NSStringFromClass(cell.class)];
        }
    }
}



@end
