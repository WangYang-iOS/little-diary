//
//  UIImage+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, VVGradientType) {
    VVGradientTypeTopToBottom = 0,//从上到下
    VVGradientTypeLeftToRight = 1,//从左到右
    VVGradientTypeUpleftToLowright = 2,//左上到右下
    VVGradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (vvExtension)

/**
 根据rect生成纯色图片
 
 @param color color description
 @param rect rect description
 @return return value description
 */
+ (nullable UIImage *)vv_imageWithColor:(UIColor *_Nullable)color rect:(CGRect)rect;

/**  设置图片的渐变色(颜色->图片)

 @param colors 渐变颜色数组
 @param gradientType 渐变样式
 @param imgSize 图片大小
 @return 颜色->图片
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors
                             gradientType:(VVGradientType)gradientType
                                  imgSize:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
