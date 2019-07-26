//
//  NSString+WYKit.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <Foundation/Foundation.h>

@interface NSString (WYKit)

/** 搜索两个字符之间的字符串 */
+ (nullable NSString *)searchInString:(nullable NSString *)string
                   charStart:(char)start
                     charEnd:(char)end;

/** 搜索两个字符之间的字符串 */
- (nullable NSString *)searchCharStart:(char)start
                      charEnd:(char)end;

/** 创建一个MD5字符串 */
- (nullable NSString *)MD5;

/** 创建一个SHA1字符串 */
- (nullable NSString *)SHA1;

/** 创建一个SHA256字符串 */
- (nullable NSString *)SHA256;

/** 创建一个SHA512字符串 */
- (nullable NSString *)SHA512;

/** 检查自身是否追加字符串 */
- (BOOL)hasString:(nullable NSString *)substring;

/** 检查自身是否是一个email */
- (BOOL)isEmail;

/** 检查给定的字符串是否是一个email */
+ (BOOL)isEmail:(nullable NSString *)email;

/** 字符串转换为UTF8 */
+ (nullable NSString *)convertToUTF8Entities:(nullable NSString *)string;

/** 编码给定的字符串成Base64 */
+ (nullable NSString *)encodeToBase64:(nullable NSString *)string;

/** 编码自身成Base64 */
- (nullable NSString *)encodeToBase64;

/** 解码给定的字符串成Base64 */
+ (nullable NSString *)decodeBase64:(nullable NSString *)string;

/** 解码自身成Base64 */
- (nullable NSString *)decodeBase64;

/** 转换自身为开头大写字符串 */
- (nullable NSString *)sentenceCapitalizedString;

/** 返回一个从时间戳人类易读的字符串 */
- (nullable NSString *)dateFromTimestamp;

/** 自编码成编码的URL字符串 */
- (nullable NSString *)urlEncode;

#pragma mark - *****  日期时间处理 类

/** 时间转字符串【YYYY-MM-dd HH:mm:ss】 */
+ (nullable NSString *)stringWithDate:(nullable NSDate *)date;

/** 获取今天的日期 YYYY年MM月dd日 */
+ (nullable NSString *)getTodayDate;

/** 获取今年的年份 YYYY */
+ (nullable NSString *)getYearDate;

/** 获取今天日期的日 dd */
+ (nullable NSString *)getDayDate;

/** 获取这个月的月份 MM */
+ (nullable NSString *)getMonthDate;

/** 获得系统当前日期和时间 */
+ (nullable NSString *)time_getCurrentDateAndTime;

/** 时间戳转换【YYYY-MM-dd HH:mm:ss】 */
+ (nullable NSString *)time_getCurrentDateAndTimeWithTimeString:(nullable NSString *)string;

/** 时间戳转换【YYYY-MM-dd】 */
+ (nullable NSString *)time_getDateWithTimeString:(nullable NSString *)string;

/** 根据指定格式时间戳转换 */
+ (nullable NSString *)time_getDateWithTime:(long long)time
                               atDateFormat:(nullable NSString *)format;

/** 时间戳转换【HH:mm】 */
+ (nullable NSString *)time_getTimeWithTimeString:(nullable NSString *)string;

/** 获取当前时间戳  */
+ (nullable NSString *)time_getTimeStamp;

/** 字符串时间—>时间戳 */
+ (nullable NSString *)cTimestampFromString:(nullable NSString *)theTime
                               atDateFormat:(nullable NSString *)format;

/** 判断字符串是否为空 */
- (BOOL)empty;

/** 判断是否为整型 */
- (BOOL)isInteger;

/** 判断是否为浮点型 */
- (BOOL)isFloat;

/** 判断是否含有数字 */
- (BOOL)isHasNumder;

/** 判断是否url */
- (BOOL)isUrl;

/** 判断是否是网络地址 */
- (BOOL)isUrlAddress;

/** 匹配数字 */
- (BOOL)isNumbers;

/** 匹配英文字母 */
- (BOOL)isLetter;

/** 匹配大写英文字母 */
- (BOOL)isCapitalLetter;

/** 匹配小写英文字母 */
- (BOOL)isSmallLetter;

/** 匹配数字+英文字母 */
- (BOOL)isLetterAndNumbers;

/** 匹配中文，英文字母和数字及_ */
- (BOOL)isChineseAndLetterAndNumberAndBelowLine;

/** 匹配中文，英文字母和数字及_ 并限制字数 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10;

/** 匹配含有汉字、数字、字母、下划线不能以下划线开头和结尾 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;

/** 检测是否含有某个字符 */
- (BOOL)containString:(NSString * _Nonnull)string;

/** 是否含有汉字 */
- (BOOL)containsChineseCharacter;

/** 计算String中英混合字数 */
- (NSInteger)stringLength;

/** email 转换为 913******@qq.com 形式 */
- (NSString * _Nonnull)emailChangeToPrivacy;

/** 计算文本高度 */
- (CGFloat)heightWithFont:(UIFont * _Nonnull)font
                 andWidth:(CGFloat)width;

/** 计算文本宽度 */
- (CGFloat)widthWithFont:(UIFont * _Nonnull)font;

/** 查找字符串中相同的某个字符的所有下标位置 */
+ (NSMutableArray *_Nonnull)getRangeStr:(NSString *_Nonnull)text
                       findText:(NSString *_Nonnull)findText;

/** 跟据文字计算宽和高 */
- (CGSize)sizeWithFontSize:(CGFloat)fontSize
                   maxSize:(CGSize)maxSize;

- (CGSize)textSizeWithFont:(UIFont *_Nullable)font
         constrainedToSize:(CGSize)size
             lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)calculateTitleSize:(CGFloat)size;


/** 字典,数组转 JSON */
+ (NSString *)idObjectToJson:(nullable id)object;

/** 小数点格式化字符串 2.0 -> 2  **  2.1 -> 2.1  **  2.121 -> 2.12   */
+ (nullable NSString *)formatFloat:(double)d;

/** 三位数加一个逗号小数点后的忽略 */
+ (nullable NSString *)strmethodComma:(nullable NSString *)string;

/** 秒数转换成时分秒 */
+ (nullable NSString *)timeformatFromSeconds:(long)totalSeconds;

/** 汉字转拼音 */
+ (nullable NSString *)transformPinYinWithString:(nullable NSString *)chinese;

/** 版本比较 */
- (NSComparisonResult)compareVersionString:(NSString *)str;

/** 阿拉伯数字转汉字 */
+ (NSString *)translationArabicNum:(NSInteger)arabicNum;

@end
