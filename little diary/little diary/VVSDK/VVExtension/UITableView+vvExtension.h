//
//  UITableView+vvExtension.h
//  vvExtension
//
//  Created by wangyang on 2019/12/9.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (vvExtension)

- (void)vv_registerCellNib:(NSString *)classString;
- (void)vv_registerCellClass:(NSString *)classString;
- (void)vv_registerCellHeaderFooterNib:(NSString *)classString;
- (void)vv_registerCellHeaderFooterClass:(NSString *)classString;
- (void)vv_estimatedHeight;

@end

NS_ASSUME_NONNULL_END
