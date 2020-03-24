//
//  VVFileManager.h
//  youleyixia
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVFileManager : NSObject

+ (instancetype)fileManager;

- (NSString *)vv_getFilePath:(NSString *)filePath;

- (BOOL)vv_writeToFile:(NSString *)file content:(id)content;

@end

NS_ASSUME_NONNULL_END
