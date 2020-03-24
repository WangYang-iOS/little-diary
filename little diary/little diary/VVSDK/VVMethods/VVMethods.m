//
//  VVMethods.m
//  VVCategory
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import "VVMethods.h"

@implementation VVMethods

#pragma mark -
#pragma mark - 系统层级 获取当前VC

/**
获取主window

@return return value description
*/
+ (UIWindow *)vv_keyWindow {
    UIWindow* window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

/**
 获取当前VC
 
 @return return value description
 */
+ (UIViewController *)vv_currentVC {
    UIViewController *result = nil;
    UIWindow* window = [self vv_keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else {
        if (window.subviews.count > 0) {
            UIView *frontView = [[window subviews] objectAtIndex:0];
            nextResponder = [frontView nextResponder];
            if (![nextResponder isKindOfClass:[UIViewController class]]) {
                nextResponder = appRootVC;
            }
        }else {
            nextResponder = appRootVC;
        }
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = tabbar.selectedViewController ; // 上下两种写法都行
        result = nav.childViewControllers.lastObject;
        if (!result) {
            result = nav;
        }
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else {
        result = nextResponder;
    }
    return result;
}

/**
 获取最上层VC
 
 @return return value description
 */
+ (UIViewController*)vv_topViewController {
    return [self vv_topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)vv_topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController*)rootViewController;
        return [self vv_topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)rootViewController;
        return [self vv_topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self vv_topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma mark -
#pragma mark - 倒计时

/**
 倒计时
 
 @param allSecond 总秒数
 @param perSecond 每秒回调
 @param end 结束回调
 */
+ (void)vv_countDownWithAllSecond:(NSInteger)allSecond
                        perSecond:(void(^)(NSInteger second))perSecond
                              end:(void(^)(void))end {
    if (allSecond == 0) {
        return;
    }
    __block NSInteger timeout = allSecond;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (end) {
                    end();
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (perSecond) {
                    perSecond(timeout);
                }
                timeout --;
            });
        }
    });
    dispatch_resume(_timer);
}


#pragma mark -
#pragma mark - 关于存储

/**
 NSUserDefaults
 
 @param key key description
 @return return value description
 */
+ (id)vv_valuerForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

/**
 NSUserDefaults
 
 @param value value description
 @param key key description
 */
+ (void)vv_setValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 NSUserDefaults
 
 @param key key description
 */
+ (void)vv_removeValueForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

#pragma mark -
#pragma mark - 关于系统弹框

/**
 弹框 UIAlertViewController
 
 @param title 标题
 @param message 提示语
 @param cancelButtonTitle 取消按钮
 @param sureButtonTitle 确定按钮
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)vv_showAlertViewWithTitle:(NSString *)title
                                         message:(NSString *)message
                               cancelButtonTitle:(NSString *)cancelButtonTitle
                                 sureButtonTitle:(NSString *)sureButtonTitle
                                     cancelBlock:(void(^)(void))cancelBlock
                                       sureBlock:(void(^)(void))sureBlock {
    UIViewController *viewController = [self vv_currentVC];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (sureButtonTitle) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:sureButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alertVC addAction:actionSure];
    }
    if (cancelButtonTitle.length) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVC addAction:actionCancel];
    }
//    alertVC.view.tintColor = [UIColor blackColor];
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        alertVC.popoverPresentationController.sourceView = [(UIViewController *)viewController view];
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}

/**
 弹框 UIAlertViewController 带输入框
 
 @param title 标题
 @param message 提示语
 @param placeholder 占位图
 @param cancelButtonTitle 取消按钮
 @param sureButtonTitle 确定按钮
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)vv_showTextFieldAlertViewWithTitle:(NSString *)title
                                               message:(NSString *)message
                                              placeholder:(NSString *)placeholder
                                        cancelButtonTitle:(NSString *)cancelButtonTitle
                                          sureButtonTitle:(NSString *)sureButtonTitle
                                              cancelBlock:(void(^)(void))cancelBlock
                                                sureBlock:(void(^)(NSString *text))sureBlock {
    UIViewController *viewController = [self vv_currentVC];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
    }];
    if (sureButtonTitle) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:sureButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock(alertVC.textFields.lastObject.text);
            }
        }];
        [alertVC addAction:actionSure];
    }
    if (cancelButtonTitle.length) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVC addAction:actionCancel];
    }
//    alertVC.view.tintColor = [UIColor blackColor];
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        alertVC.popoverPresentationController.sourceView = [(UIViewController *)viewController view];
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}

/**
 弹框 UIAlertViewController sheet
 
 @param title 标题
 @param message 提示语
 @param cancelButtonTitle 取消按钮
 @param titleArray 按钮标题数组
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)vv_showSheetViewWithTitle:(NSString *)title
                                         message:(NSString *)message
                               cancelButtonTitle:(NSString *)cancelButtonTitle
                                      titleArray:(NSArray <NSString *>*)titleArray
                                     cancelBlock:(void(^)(void))cancelBlock
                                       sureBlock:(void (^)(UIAlertAction *))sureBlock {
    UIViewController *viewController = [self vv_currentVC];
    UIAlertController *sheetVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock(action);
            }
        }];
        [sheetVC addAction:actionSure];
    }];
    if (cancelButtonTitle) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [sheetVC addAction:actionCancel];
    }
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        sheetVC.popoverPresentationController.sourceView = [(UIViewController *)viewController view];
    }
//    sheetVC.view.tintColor = [UIColor blackColor];
//    //改变title的大小和颜色
//    if (title.length > 0) {
//        NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
//        [titleAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, title.length)];
//        [titleAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
//        [sheetVC setValue:titleAtt forKey:@"attributedTitle"];
//    }
//    if (message.length > 0) {
//        //改变message的大小和颜色
//        NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
//        [messageAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, message.length)];
//        [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, message.length)];
//        [sheetVC setValue:messageAtt forKey:@"attributedMessage"];
//    }
    [viewController presentViewController:sheetVC animated:YES completion:nil];
    return sheetVC;
}

@end
