//
//  UILabel+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (vvExtension)

+ (UILabel *)vv_labelWithFont:(UIFont *)font
                    textColor:(NSString *)textColor;

+ (UILabel *)vv_labelWithFont:(UIFont *)font
                    textColor:(NSString *)textColor
                textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)vv_labelWithText:(NSString *)text
                         font:(UIFont *)font
                    textColor:(NSString *)textColor
                textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
