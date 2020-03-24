//
//  VVBaseViewController.m
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVBaseViewController.h"

@interface VVBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation VVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initBackButton];
}

- (void)initBackButton {
    if (self.navigationController.childViewControllers.count < 2) {
        return;
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(vv_goBack)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)vv_goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
