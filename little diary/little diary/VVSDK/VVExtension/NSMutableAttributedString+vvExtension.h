//
//  NSMutableAttributedString+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (vvExtension)

- (NSMutableAttributedString *)vv_attributedSubstringWithLineSpace:(CGFloat)lineSpace;
- (NSMutableAttributedString *)vv_attributedSubstringWithFont:(UIFont *)font;
- (NSMutableAttributedString *)vv_attributedSubstringWithFont:(UIFont *)font rangeString:(NSString *)rangeString;
- (NSMutableAttributedString *)vv_attributedSubstringWithFont:(UIFont *)font range:(NSRange)range;
- (NSMutableAttributedString *)vv_attributedSubstringWithTextColor:(UIColor *)textColor;
- (NSMutableAttributedString *)vv_attributedSubstringWithTextColor:(UIColor *)textColor rangeString:(NSString *)rangeString;
- (NSMutableAttributedString *)vv_attributedSubstringWithTextColor:(UIColor *)textColor range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
