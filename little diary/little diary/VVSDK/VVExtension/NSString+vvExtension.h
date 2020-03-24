//
//  NSString+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (vvExtension)

/// attributedStr
- (NSMutableAttributedString *)vv_attributedStr;

/**
 字符串宽度
 
 @param font 字体
 @return 宽度
 */
- (CGFloat)vv_widthWithFont:(UIFont *)font;

/**
 根据字体大小 字间距 计算字符串宽度
 
 @param font font description
 @param wordSpace wordSpace description
 @return return value description
 */
- (CGFloat)vv_widthWithFont:(UIFont *)font wordSpace:(CGFloat)wordSpace;

/**
 字符串高度
 
 @param font 字体
 @return 高度
 */
- (CGFloat)vv_heightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 根据字体大小 行间距 宽度 计算字符串高度
 
 @param font font description
 @param lineSpace lineSpace description
 @param width width description
 @return return value description
 */
- (CGFloat)vv_heightWithFont:(UIFont *)font
                   lineSpace:(CGFloat)lineSpace
                       width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
