//
//  NSObject+vvRuntime.h
//  vvExtension
//
//  Created by wangyang on 2019/12/10.
//  Copyright © 2019 iule. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (vvRuntime)

/**
 获取对象所有属性
 
 @return return value description
 */
- (NSArray *)vv_getAllProperties;

/**
 获取对象所有方法
 
 @return return value description
 */
- (NSArray *)vv_getAllMethods;

/**
 获取对象的所有属性和属性内容
 
 @param obj obj description
 @return return value description
 */
+ (NSDictionary *)vv_getAllPropertiesAndVaules:(NSObject *)obj;

@end

NS_ASSUME_NONNULL_END
