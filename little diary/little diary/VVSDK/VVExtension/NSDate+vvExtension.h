//
//  NSDate+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (vvExtension)

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isBeforeYesterday;

/**
 date 转 固定格式时间
 
 @param formatter 格式
 @return 字符串
 */
- (NSString *)vv_stringForFormatter:(NSString *)formatter ;

/**
 date 转 时间戳字符串
 
 @return 时间戳字符串
 */
- (NSString *)vv_timestamp;

/**
 时间戳 转 固定格式时间
 
 @param timeString 时间戳字符串
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)vv_stringWith1970TimeString:(NSString *)timeString
                                formatter:(NSString *)formatter;

/**
 时间字符串格式转换
 
 @param timeString 需要转换的时间字符串
 @param fromFormatter 当前格式
 @param toFormatter 转换后的格式
 @return 新的时间字符串
 */
+ (NSString *)vv_stringWithTimeString:(NSString *)timeString
                        fromFormatter:(NSString *)fromFormatter
                          toFormatter:(NSString *)toFormatter;

/**
 固定格式时间 转 时间戳
 
 @param timeString 时间
 @param formatter 格式
 @return 时间戳
 */
+ (NSString *)vv_timestampWithTimeString:(NSString *)timeString
                               formatter:(NSString *)formatter;


/**
 固定格式时间 转 date
 
 @param timeString 时间字符串
 @param formatter 格式
 @return date
 */
+ (NSDate *)vv_dateWithTimeString:(NSString *)timeString
                        formatter:(NSString *)formatter;

/**
 时间戳 转 date
 
 @param timeString 时间戳
 @return date
 */
+ (NSDate *)vv_dateWith1970TimeString:(NSString *)timeString;

/// 获取星期几
- (NSString *)vv_weekdayString;

@end

NS_ASSUME_NONNULL_END
