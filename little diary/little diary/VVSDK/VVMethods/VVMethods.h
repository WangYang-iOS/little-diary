//
//  VVMethods.h
//  VVCategory
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVMethods : NSObject

#pragma mark -
#pragma mark - 系统层级 获取当前VC

/**
获取主window

@return return value description
*/
+ (UIWindow *)vv_keyWindow;

/**
 获取当前VC
 
 @return return value description
 */
+ (UIViewController *)vv_currentVC;

/**
 获取最上层VC
 
 @return return value description
 */
+ (UIViewController*)vv_topViewController;

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
                              end:(void(^)(void))end;

#pragma mark -
#pragma mark - 关于存储

/**
 NSUserDefaults
 
 @param key key description
 @return return value description
 */
+ (id)vv_valuerForKey:(NSString *)key;

/**
 NSUserDefaults
 
 @param value value description
 @param key key description
 */
+ (void)vv_setValue:(id)value forKey:(NSString *)key;

/**
 NSUserDefaults

 @param key key description
 */
+ (void)vv_removeValueForKey:(NSString *)key;

#pragma mark -
#pragma mark - 关于系统弹框

/**
 弹框 UIAlertViewController 取消 + 确定 alert
 
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
                                       sureBlock:(void(^)(void))sureBlock;

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
                                                sureBlock:(void(^)(NSString *text))sureBlock;

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
                                       sureBlock:(void(^)(UIAlertAction *action))sureBlock;

@end

NS_ASSUME_NONNULL_END
