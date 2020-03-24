//
//  UITextField+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (vvExtension)

@property (nonatomic, assign) NSInteger vv_limitCount;

/**
 设置占位符颜色
 
 @param color color description
 */
- (void)vv_placeholderColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
