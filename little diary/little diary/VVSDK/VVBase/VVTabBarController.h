//
//  VVTabBarController.h
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVTabBarController : UITabBarController

/**
 *  主页成为根数图控制器
 */
- (void)vv_tabBarControllerWithControllers:(NSArray *)controllers
                            darkImageNames:(NSArray *)darkImageNames
                           lightImageNames:(NSArray *)lightImageNames
                               tabBarNames:(NSArray *)names;

@end

NS_ASSUME_NONNULL_END
