//
//  UITableView+vvExtension.m
//  vvExtension
//
//  Created by wangyang on 2019/12/9.
//  Copyright © 2019 iule. All rights reserved.
//

#import "UITableView+vvExtension.h"

@implementation UITableView (vvExtension)

- (void)vv_registerCellNib:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:nil] forCellReuseIdentifier:classString];
}

- (void)vv_registerCellClass:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:classString];
}

- (void)vv_registerCellHeaderFooterNib:(NSString *)classString {
    [self registerNib:[UINib nibWithNibName:classString bundle:nil] forHeaderFooterViewReuseIdentifier:classString];
}

- (void)vv_registerCellHeaderFooterClass:(NSString *)classString {
    [self registerClass:NSClassFromString(classString) forHeaderFooterViewReuseIdentifier:classString];
}

- (void)vv_estimatedHeight {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
