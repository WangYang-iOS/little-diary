//
//  VVBaseNavigationController.m
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVBaseNavigationController.h"
#import "UIColor+vvExtension.h"
#import "UIImage+vvExtension.h"

@interface VVBaseNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation VVBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    [self setNavigationBarBackgroundColor:[UIColor vv_colorWithHexString:@"ffffff"]
                               titleColor:[UIColor vv_colorWithHexString:@"333333"]
                                titleFont:[UIFont boldSystemFontOfSize:17]];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color
                             titleColor:(UIColor *)titleColor
                              titleFont:(UIFont *)titleFont {
    self.navigationBar.translucent = NO;
    UIImage *image = [UIImage vv_imageWithColor:color rect:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height)];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont};
    self.navigationBar.tintColor = titleColor;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = [self.viewControllers count] > 1 ;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

@end
