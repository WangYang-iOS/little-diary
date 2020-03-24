//
//  VVTableAdapter.h
//  youleyixia
//
//  Created by wangyang on 2019/12/13.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfigureCellBlock)(UITableViewCell *cell, id model);
typedef void(^SelectedCellBlock)(NSIndexPath *indexPath);

@interface VVTableAdapter : NSObject
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSArray *dataArray;

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
           configureCellBlock:(ConfigureCellBlock)configureCellBlock
              selectCellBlock:(SelectedCellBlock)selectCellBlock;

+ (UITableView *)tableView:(id)delegate;
+ (UITableView *)adjustRowHieghtTableView:(id)delegate;

@end

NS_ASSUME_NONNULL_END
