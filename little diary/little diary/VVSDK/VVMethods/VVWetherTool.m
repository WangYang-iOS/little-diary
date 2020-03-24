//
//  VVWetherTool.m
//  youleyixia
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVWetherTool.h"

static const NSString *vv_wetherURL = @"https://api.seniverse.com/v3/weather/now.json?key=SfG-5J1vkd_b6N2Yf";

@interface VVWetherTool ()
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation VVWetherTool

+ (instancetype)wetherTool {
    static VVWetherTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[VVWetherTool alloc] init];
    });
    return tool;
}

/**
 请求天气

 @param location location description
 @param callback callback description
 */
+ (void)vv_requestWetherWithLocation:(NSString *)location callback:(void(^)(NSDictionary * result))callback {
    if (location.length == 0) {
        return;
    }
    NSString *googleURL =[NSString stringWithFormat:@"%@&location=%@&language=zh-Hans&unit=c",vv_wetherURL,location];
    NSURL *url = [NSURL URLWithString:googleURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *dic = [[json[@"results"] firstObject] objectForKey:@"now"];
                if (dic && callback) {
                    callback(dic);
                }
            }else {
                NSLog(@"error == %@",error.userInfo);
            }
        });
    }];
    [VVWetherTool wetherTool].task = task;
    [task resume];
}

@end
