//
//  UIView+vvExtension.m
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import "UIView+vvExtension.h"
#import "UIColor+vvExtension.h"

@implementation UIView (vvExtension)
@dynamic vv_x,vv_y,vv_width,vv_height,vv_centerX,vv_centerY;

#pragma mark -
#pragma mark - 渐变色

/**  设置View的渐变色

 @param colors 渐变颜色数组
 @param gradientType 渐变样式
 */
- (void)vv_gradientColorFromColors:(NSArray*)colors
                      gradientType:(VVGradientType)gradientType {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case VVGradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, 1);
            break;
        case VVGradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(1, 0.0);
            break;
        case VVGradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(1, 1);
            break;
        case VVGradientTypeUprightToLowleft:
            start = CGPointMake(1, 0.0);
            end = CGPointMake(0.0, 1);
            break;
        default:
            break;
    }
    gradient.startPoint = start;
    gradient.endPoint = end;
    gradient.frame = self.bounds;
    NSMutableArray *array = @[].mutableCopy;
    for (UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }
    gradient.colors = array;
    [self.layer insertSublayer:gradient atIndex:0];
}


#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
- (CGFloat)vv_x {
    return self.frame.origin.x;
}

/**
 设置视图 x 坐标

 @param vv_x vv_x description
 */
- (void)setVv_x:(CGFloat)vv_x {
    CGRect frame = self.frame;
    frame.origin.x = vv_x;
    self.frame = frame;
}

/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
- (CGFloat)vv_y {
    return self.frame.origin.y;
}

/**
 设置视图 y 坐标

 @param vv_y vv_y description
 */
- (void)setVv_y:(CGFloat)vv_y {
    CGRect frame = self.frame;
    frame.origin.y = vv_y;
    self.frame = frame;
}

/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
- (CGFloat)vv_width {
    return self.frame.size.width;
}

/**
 设置视图 宽度

 @param vv_width vv_width description
 */
- (void)setVv_width:(CGFloat)vv_width {
    CGRect frame = self.frame;
    frame.size.width = vv_width;
    self.frame = frame;
}

/**
 * 获取视图 高度
 *
 *  @return 高度
 */
- (CGFloat)vv_height {
    return self.frame.size.height;
}

/**
 设置视图 高度

 @param vv_height vv_height description
 */
- (void)setVv_height:(CGFloat)vv_height {
    CGRect frame = self.frame;
    frame.size.height = vv_height;
    self.frame = frame;
}

/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
- (CGFloat)vv_centerX {
    return self.center.x;
}

/**
 设置视图 中心点 X
 
 @param vv_centerX vv_centerX description
 */
- (void)setVv_centerX:(CGFloat)vv_centerX {
    CGPoint center = self.center;
    center.x = vv_centerX;
    self.center = center;
}

/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
- (CGFloat)vv_centerY {
    return self.center.y;
}

/**
 设置视图 中心点 Y

 @param vv_centerY vv_centerY description
 */
- (void)setVv_centerY:(CGFloat)vv_centerY {
    CGPoint center = self.center;
    center.y = vv_centerY;
    self.center = center;
}

/**
 * 获取视图 最右边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)vv_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setVv_maxX:(CGFloat)vv_maxX {
    CGRect newFrame   = self.frame;
    newFrame.origin.x = vv_maxX - self.frame.size.width;
    self.frame        = newFrame;
}

/**
 * 获取视图 最下边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)vv_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setVv_maxY:(CGFloat)vv_maxY {
    CGRect newFrame   = self.frame;
    newFrame.origin.y = vv_maxY - self.frame.size.height;
    self.frame        = newFrame;
}

#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)vv_fillCorner {
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.layer.masksToBounds = YES;
}

/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)vv_cornerWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)vv_borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString {
    self.layer.borderColor = [UIColor vv_colorWithHexString:colorString].CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

/**
 设置阴影
 
 @param colorString colorString description
 @param opacity opacity description
 @param radius radius description
 @param offset offset description
 */
- (void)vv_shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    self.layer.shadowColor = [UIColor vv_colorWithHexString:colorString].CGColor; /// 阴影颜色
    self.layer.shadowOpacity = opacity; /// 阴影透明度
    self.layer.shadowRadius = radius; /// 阴影半径 默认 3
    self.layer.shadowOffset = offset; /// 向右 向下 偏移
}

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)vv_lineFromTop:(float)top left:(float)left toRight:(float)right {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor vv_colorWithHexString:@"e5e5e5"].CGColor;
    layer.frame = CGRectMake(left, top, [self vv_width] - left - right, 0.5);
    [self.layer addSublayer:layer];
}
/**
 *  上部横线
 */
- (void)vv_topLine {
    [self vv_lineFromTop:0 left:0 toRight:0];
}
/**
 *  下部横线
 */
- (void)vv_bottomLine {
    [self vv_lineFromTop:[self vv_height] - 0.5  left:0 toRight:0];
}

#pragma mark
#pragma mark -- XIB

- (void)setVv_radius:(CGFloat)vv_radius {
    self.layer.cornerRadius = vv_radius;
    self.layer.masksToBounds = YES;
}
- (CGFloat)vv_radius {
    return self.layer.cornerRadius;
}
- (void)setVv_borderWidth:(CGFloat)vv_borderWidth {
    self.layer.borderWidth = vv_borderWidth;
}
- (CGFloat)vv_borderWidth {
    return self.layer.borderWidth;
}
- (void)setVv_borderColor:(UIColor *)vv_borderColor {
    self.layer.borderColor = vv_borderColor.CGColor;
    self.layer.masksToBounds = YES;
}
- (UIColor *)vv_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setVv_shadowRadius:(CGFloat)vv_shadowRadius {
    self.layer.shadowRadius = vv_shadowRadius;
}
- (CGFloat)vv_shadowRadius {
    return self.layer.shadowRadius;
}
- (void)setVv_shadowColor:(UIColor *)vv_shadowColor {
    self.layer.shadowColor = vv_shadowColor.CGColor;
}
- (UIColor *)vv_shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
- (void)setVv_shadowOffset:(CGSize)vv_shadowOffset {
    self.layer.shadowOffset = vv_shadowOffset;
}
- (CGSize)vv_shadowOffset {
    return self.layer.shadowOffset;
}
- (void)setVv_shadowOpacity:(CGFloat)vv_shadowOpacity {
    self.layer.shadowOpacity = vv_shadowOpacity;
}
- (CGFloat)vv_shadowOpacity {
    return self.layer.shadowOpacity;
}

+ (instancetype)vv_loadXib {
    return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

@end
