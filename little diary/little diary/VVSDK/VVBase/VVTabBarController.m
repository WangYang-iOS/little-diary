//
//  VVTabBarController.m
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVTabBarController.h"
#import "VVBaseNavigationController.h"
#import "UIColor+vvExtension.h"
#import "VVConst.h"

@interface VVTabBarController ()

@end

@implementation VVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  主页成为根数图控制器
 */
- (void)vv_tabBarControllerWithControllers:(NSArray *)controllers
                            darkImageNames:(NSArray *)darkImageNames
                           lightImageNames:(NSArray *)lightImageNames
                               tabBarNames:(NSArray *)names {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i < controllers.count; i ++) {
        //图标
        UIImage * image1 = [UIImage imageNamed:lightImageNames [i]];
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * image2 = [UIImage imageNamed:darkImageNames [i]];;
        image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIViewController *vc = [NSClassFromString(controllers [i]) new];
        VVBaseNavigationController *nav = [[VVBaseNavigationController alloc] initWithRootViewController:vc];
        [nav preferredStatusBarStyle];
        nav.tabBarItem.title = names [i];
        nav.tabBarItem.image = image2;
        nav.tabBarItem.selectedImage = image1;
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
        [array addObject:nav];
        // 设置标题样式
        [nav.tabBarItem setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor vv_colorWithHexString:@"FF4500"],
          NSForegroundColorAttributeName,
          [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0],
          NSFontAttributeName,
          nil]
                                      forState:UIControlStateSelected];
        [nav setNavigationBarBackgroundColor:[UIColor vv_colorWithHexString:@"FF4500"] titleColor:[UIColor vv_colorWithHexString:@"FFFFFF"] titleFont:VVBFONT(17)];
    }
    
    self.viewControllers = array;
//    self.tabBar.barTintColor = [UIColor clearColor];
}


@end
