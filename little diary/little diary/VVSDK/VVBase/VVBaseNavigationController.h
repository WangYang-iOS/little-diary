//
//  VVBaseNavigationController.h
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseNavigationController : UINavigationController

- (void)setNavigationBarBackgroundColor:(UIColor *)color
                             titleColor:(UIColor *)titleColor
                              titleFont:(UIFont *)titleFont;
@end

NS_ASSUME_NONNULL_END
