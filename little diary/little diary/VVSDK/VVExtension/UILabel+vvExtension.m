//
//  UILabel+vvExtension.m
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import "UILabel+vvExtension.h"
#import "UIColor+vvExtension.h"

@implementation UILabel (vvExtension)

+ (UILabel *)vv_labelWithFont:(UIFont *)font
                    textColor:(NSString *)textColor {
    return [UILabel vv_labelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)vv_labelWithFont:(UIFont *)font
                    textColor:(NSString *)textColor
                textAlignment:(NSTextAlignment)textAlignment {
    return [UILabel vv_labelWithText:@"" font:font textColor:textColor textAlignment:textAlignment];
}

+ (UILabel *)vv_labelWithText:(NSString *)text
                         font:(UIFont *)font
                    textColor:(NSString *)textColor
                textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = [UIColor vv_colorWithHexString:textColor];
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
}

@end
