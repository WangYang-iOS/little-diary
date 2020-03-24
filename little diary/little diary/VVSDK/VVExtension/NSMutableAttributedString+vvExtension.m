//
//  NSMutableAttributedString+vvExtension.m
//  vvExtension
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import "NSMutableAttributedString+vvExtension.h"

@implementation NSMutableAttributedString (vvExtension)

- (NSMutableAttributedString *)vv_attributedSubstringWithLineSpace:(CGFloat)lineSpace {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpace;
    [self addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.string.length - 1)];
    return self;
}

- (NSMutableAttributedString *)vv_attributedSubstringWithFont:(UIFont *)font {
    [self vv_attributedSubstringWithFont:font rangeString:self.string];
    return self;
}

- (NSMutableAttributedString *)vv_attributedSubstringWithFont:(UIFont *)font rangeString:(NSString *)rangeString {
    [self addAttribute:NSFontAttributeName value:font range:[self.string rangeOfString:rangeString]];
    return self;
}
- (NSMutableAttributedString *)vv_attributedSubstringWithFont:(UIFont *)font range:(NSRange)range {
    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}

- (NSMutableAttributedString *)vv_attributedSubstringWithTextColor:(UIColor *)textColor {
    [self vv_attributedSubstringWithTextColor:textColor rangeString:self.string];
    return self;
}

- (NSMutableAttributedString *)vv_attributedSubstringWithTextColor:(UIColor *)textColor rangeString:(NSString *)rangeString {
    [self addAttribute:NSForegroundColorAttributeName value:textColor range:[self.string rangeOfString:rangeString]];
    return self;
}

- (NSMutableAttributedString *)vv_attributedSubstringWithTextColor:(UIColor *)textColor range:(NSRange)range {
    [self addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    return self;
}

@end
