//
//  UIView+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+vvExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (vvExtension)

#pragma mark -
#pragma mark - 渐变色

/**  设置View的渐变色

 @param colors 渐变颜色数组
 @param gradientType 渐变样式
 */
- (void)vv_gradientColorFromColors:(NSArray*)colors
                      gradientType:(VVGradientType)gradientType;

#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
@property (nonatomic, assign) CGFloat vv_x;

/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
@property (nonatomic, assign) CGFloat vv_y;

/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
@property (nonatomic, assign) CGFloat vv_width;

/**
 * 获取视图 高度
 *
 *  @return 高度
 */
@property (nonatomic, assign) CGFloat vv_height;

/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
@property (nonatomic, assign) CGFloat vv_centerX;

/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
@property (nonatomic, assign) CGFloat vv_centerY;

/**
* 获取视图 最右边 距 父视图左边 距离
*
*  @return 距离
*/
@property (nonatomic, assign) CGFloat vv_maxX;

/**
* 获取视图 最下边 距 父视图上边 距离
*
*  @return 距离
*/
@property (nonatomic, assign) CGFloat vv_maxY;


#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)vv_fillCorner;
/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)vv_cornerWithRadius:(CGFloat)radius;
/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)vv_borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString;

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)vv_lineFromTop:(float)top left:(float)left toRight:(float)right;
/**
 *  上部横线
 */
- (void)vv_topLine;
/**
 *  下部横线
 */
- (void)vv_bottomLine;

/**
 颜色 透明度 半径 偏移
 
 @param colorString 1
 @param opacity 1
 @param radius 1
 @param offset 1
 */
- (void)vv_shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

#pragma mark
#pragma mark -- XIB

@property(assign, nonatomic) IBInspectable CGFloat vv_radius;
@property(assign, nonatomic) IBInspectable CGFloat vv_borderWidth;
@property(strong, nonatomic) IBInspectable UIColor *vv_borderColor;

@property(assign, nonatomic) IBInspectable CGFloat vv_shadowRadius;
@property(strong, nonatomic) IBInspectable UIColor *vv_shadowColor;
@property(assign, nonatomic) IBInspectable CGFloat vv_shadowOpacity;
@property(assign, nonatomic) IBInspectable CGSize vv_shadowOffset;

+ (instancetype)vv_loadXib;

@end

NS_ASSUME_NONNULL_END
