//
//  UIColor+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/9.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (vvExtension)

/**
 *  获取颜色 含有alpha
 *
 *  @param color 6位16进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)vv_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  获取颜色
 *
 *  @param color 6位16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)vv_colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
