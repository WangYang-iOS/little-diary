//
//  VVLocationManager.m
//  youleyixia
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVLocationManager.h"
#import "VVMethods.h"

@interface VVLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation VVLocationManager

+ (instancetype)locationManager {
    static VVLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VVLocationManager alloc] init];
    });
    return manager;
}

- (void)vv_startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }else {
        [VVMethods vv_showAlertViewWithTitle:@"提示" message:@"请在设置中打开定位" cancelButtonTitle:@"取消" sureButtonTitle:@"打开定位" cancelBlock:^{} sureBlock:^{
            NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:settingURL];
        }];
    }
}

- (void)vv_stopLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager stopUpdatingLocation];
    }
}

#pragma mark -
#pragma mark - CLLocationManagerDelegate

//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [VVMethods vv_showAlertViewWithTitle:@"提示" message:@"请在设置中打开定位" cancelButtonTitle:@"取消" sureButtonTitle:@"打开定位" cancelBlock:^{} sureBlock:^{
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
}
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self vv_stopLocation];
    CLLocation *currentLocation = [locations lastObject];
    //当前的经纬度
//    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    if (self.callback) {
        self.callback(currentLocation);
    }
}

#pragma mark -
#pragma mark - lazy

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
    }
    return _locationManager;
}

- (CLGeocoder *)geoCoder {
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

@end
