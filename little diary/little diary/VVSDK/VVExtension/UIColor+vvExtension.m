//
//  UIColor+vvExtension.m
//  vvExtension
//
//  Created by wangyang on 2019/12/9.
//  Copyright © 2019 iule. All rights reserved.
//

#import "UIColor+vvExtension.h"

@implementation UIColor (vvExtension)

/**
 *  获取颜色 含有alpha
 *
 *  @param hexString 16进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)vv_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            red   = [self vv_colorComponentFrom:colorString start:0 length:1];
            green = [self vv_colorComponentFrom:colorString start:1 length:1];
            blue  = [self vv_colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            red   = [self vv_colorComponentFrom:colorString start:1 length:1];
            green = [self vv_colorComponentFrom:colorString start:2 length:1];
            blue  = [self vv_colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            red   = [self vv_colorComponentFrom:colorString start:0 length:2];
            green = [self vv_colorComponentFrom:colorString start:2 length:2];
            blue  = [self vv_colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self vv_colorComponentFrom:colorString start:0 length:2];
            red   = [self vv_colorComponentFrom:colorString start:2 length:2];
            green = [self vv_colorComponentFrom:colorString start:4 length:2];
            blue  = [self vv_colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            blue=0;
            green=0;
            red=0;
            alpha=0;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)vv_colorComponentFrom:(NSString *)string
                           start:(NSUInteger)start
                          length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

/**
 *  获取颜色
 *
 *  @param color 6位16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)vv_colorWithHexString:(NSString *)color {
    return [self vv_colorWithHexString:color alpha:1];
}

@end
