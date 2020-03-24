//
//  VVWetherTool.h
//  youleyixia
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVWetherTool : NSObject

/**
 请求天气

 @param location location description
 @param callback callback description
 */
+ (void)vv_requestWetherWithLocation:(NSString *)location callback:(void(^)(NSDictionary * result))callback;

@end

NS_ASSUME_NONNULL_END
