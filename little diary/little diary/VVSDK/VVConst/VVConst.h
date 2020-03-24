//
//  VVConst.h
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VVWeakSelf      __weak typeof(self) weakSelf = self;
#define VVStrongSelf    __strong typeof(weakSelf) self = weakSelf;

#define VVFONT(_SIZE_)    [UIFont systemFontOfSize:_SIZE_]
#define VVBFONT(_SIZE_)   [UIFont boldSystemFontOfSize:_SIZE_]
#define VVMFONT(_SIZE_)   [UIFont systemFontOfSize:_SIZE_ weight:UIFontWeightMedium]
#define VVIMAGE(_IMAGE_)  [UIImage imageNamed:_IMAGE_]

#define VVSIZE(_W_,_H_)                 CGSizeMake(_W_, _H_)
#define VVPOINT(_X_,_Y_)                CGPointMake(_X_, _Y_)
#define VVBOUNDS(_X_,_Y_,_W_,_H_)       CGRectMake(0, 0, _W_, _H_)
#define VVRECT(_X_,_Y_,_W_,_H_)         CGRectMake(_X_, _Y_, _W_, _H_)
#define VVRANGE(_location_,_length_)    NSMakeRange(_location_,_length_)

#define VVScreenW       [UIScreen mainScreen].bounds.size.width
#define VVScreenH       [UIScreen mainScreen].bounds.size.height

#define VVIs_iphone     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define VVIs_iPhoneX    ((VVScreenW >=375.0f && VVScreenH >=812.0f) || (VVScreenW >=812.0f && VVScreenH >=375.0f))&& VVIs_iphone

#define VVStatusH       (CGFloat)(VVIs_iPhoneX?(44.0):(20.0))
#define VVNavH          (CGFloat)(VVIs_iPhoneX?(88.0):(64.0))
#define VVTabBarH       (CGFloat)(VVIs_iPhoneX?(49.0 + 34.0):(49.0))
#define VVTopSafeH      (CGFloat)(VVIs_iPhoneX?(44.0):(0))
#define VVBottomSafeH   (CGFloat)(VVIs_iPhoneX?(34.0):(0))

#ifdef DEBUG  //调试阶段
#define NSLog(...)  NSLog(__VA_ARGS__)
#else //发布阶段
#define NSLog(...)
#endif
