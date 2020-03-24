//
//  UITextView+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (vvExtension)

/** placeholdLabel */
@property(nonatomic,readonly)  UILabel * _Nonnull vv_placeholdLabel;
/** placeholder */
@property(nonatomic,copy) NSString *vv_placeholder;
/** placeholder颜色 */
@property(nonatomic,copy) UIColor *vv_placeholderColor;
/** 富文本 */
@property(nonnull,strong) NSAttributedString *vv_attributePlaceholder;
/** 位置 */
@property(nonatomic,assign) CGPoint vv_location;
/** 默认颜色 */
+ (UIColor *_Nullable)vv_defaultColor;

@end

NS_ASSUME_NONNULL_END
