//
//  VVFileManager.m
//  youleyixia
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVFileManager.h"

@implementation VVFileManager

+ (instancetype)fileManager {
    static VVFileManager *_fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fileManager = [[VVFileManager alloc] init];
    });
    return _fileManager;
}

- (BOOL)createFile:(NSString *)file {
    //在沙盒中获取Documents的完整路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //得到path下文件的路径
    NSString *filePath = [path stringByAppendingPathComponent:file];
    //判断文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }else{
        NSError *error;
        NSString *dirPath = [filePath stringByDeletingLastPathComponent];
        BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        isSuccess = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        return isSuccess;
    }
}

- (NSString *)vv_getFilePath:(NSString *)filePath {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:filePath];
}

- (BOOL)vv_writeToFile:(NSString *)file content:(id)content {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:file];
    if ([self createFile:file]) {
       return [content writeToFile:filePath atomically:NO];
    }
    return NO;
}

@end
