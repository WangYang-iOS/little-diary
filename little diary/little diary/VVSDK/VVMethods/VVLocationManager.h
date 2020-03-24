//
//  VVLocationManager.h
//  youleyixia
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVLocationManager : NSObject

@property (nonatomic, copy) void (^callback)(CLLocation *location);

+ (instancetype)locationManager;

- (void)vv_startLocation;

- (void)vv_stopLocation;

@end

NS_ASSUME_NONNULL_END
