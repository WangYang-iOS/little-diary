//
//  UIButton+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, VVButtonEdgeInsetsStyle) {
    VVButtonEdgeInsetsStyleTop, // image在上，label在下
    VVButtonEdgeInsetsStyleLeft, // image在左，label在右
    VVButtonEdgeInsetsStyleBottom, // image在下，label在上
    VVButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (vvExtension)

+ (UIButton *)vv_buttonWithTitle:(NSString *)title titleColor:(NSString *)titleColor font:(UIFont *)font;
+ (UIButton *)vv_buttonWithImage:(NSString *)image;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)vv_layoutButtonWithEdgeInsetsStyle:(VVButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
