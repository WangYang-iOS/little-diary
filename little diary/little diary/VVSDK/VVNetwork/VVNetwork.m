//
//  VVNetwork.m
//  youleyixia
//
//  Created by wangyang on 2019/12/16.
//  Copyright © 2019 wyy. All rights reserved.
//

#import "VVNetwork.h"
#import <AFNetworking.h>
#import "VVConst.h"
#import "VVMethods.h"

@implementation VVResponseMessage

- (instancetype)init {
    self = [super init];
    if (self) {
        _responseState = VVResponseNotFinish;
    }
    return self;
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl requestArgs:(NSDictionary *)requestArgs {
    self = [super init];
    if (self) {
        _requestUrl = requestUrl;
        _requestArgs = requestArgs;
        _responseState = VVResponseNotFinish;
    }
    return self;
}

@end

@implementation VVRequestMessage

- (instancetype)init {
    self = [super init];
    if (self) {
        //do something
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url args:(NSDictionary *)args {
    self = [super init];
    if (self) {
        _url = url;
        _args = args;
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url
                     method:(VVHttpMethod)method
                       args:(NSDictionary *)args {
    self = [self initWithUrl:url args:args];
    _method = method;
    return self;
}

- (instancetype)initMutipartRequestWithUrl:(NSString *)url args:(NSDictionary *)args {
    self = [self initWithUrl:url args:args];
    _method = POST;
    return self;
}

- (id)initWithUrl:(NSString *)url method:(VVHttpMethod)method args:(NSDictionary *)args paths:(NSArray *)paths {
    self = [self initWithUrl:url method:method args:args];
    _paths = paths;
    
    NSString *URLString = @"";
    NSString *version = @"";
    if ([url containsString:@"http://ifsapp.pceggs.com/IFS/SDK/SDK_PlayList.ashx"]) {
        URLString = url;
    }else if ([url containsString:@"/master/"]) {
        URLString = [NSString stringWithFormat:@"%@%@", @"", url];
    }else {
        URLString = [NSString stringWithFormat:@"%@%@%@", @"", version, url];
    }
//    URLString = [NSString stringWithFormat:@"%@%@%@", kDOMAIN, version, url];
    if (paths.count > 0) {
        NSString *paramStr = @"";
        for (NSString *arg in paths) {
            paramStr = [paramStr stringByAppendingPathComponent:arg];
        }
        URLString = [URLString stringByAppendingString:paramStr];
    }
    _url = URLString;
    
    return self;
}

+ (VVRequestMessage *)messageWithMethod:(VVHttpMethod)method
                                  url:(NSString *)url
                                   args:(NSDictionary *)args
                                  paths:(NSArray *)paths {
    VVRequestMessage *message = [[VVRequestMessage alloc] initWithUrl:url method:method args:args paths:paths];
    return message;
}

@end

typedef void (^NetworkResponseCallback)(VVResponseMessage *responseMessage);

@implementation VVNetwork

/**
 检测请求是否请求成功
 
 @param responseMessage 返回请求参数
 @param success success
 */
+ (void)checkResponseMessage:(VVResponseMessage *)responseMessage success:(RequestEngineCheckIsSuccess)success {
    if (responseMessage.responseState == VVResponseSuccessFinished) {
        ///  请求成功
        if ([responseMessage.retCode integerValue] == 1) {
            success(YES);
        }else {
            /// 请求成功并且返回错误的参数
            success(NO);
        }
    }else if (responseMessage.responseState == VVResponseFailureFinished) {
        ///  请求失败
        success(NO);
    }
}

/// post请求
/// @param params params description
/// @param url url description
/// @param block block description
+ (void)postRequestWithParams:(NSDictionary *)params url:(NSString *)url block:(RequestEngineBlock)block {
    [self postRequestWithParams:params url:url path:@[] block:block];
}

/// post请求 path
/// @param params dictionary description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)postRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block {
    VVRequestMessage *message = [VVRequestMessage messageWithMethod:POST url:url args:params paths:path];
    VVWeakSelf
    [self doRequest:message isBody:YES callbackBlock:^(VVResponseMessage *responseMessage) {
         VVStrongSelf
         [self checkResponseMessage:responseMessage success:^(BOOL success) {
             if (block) {
                 block(success,responseMessage);
             }
         }];
    }];
}

/// get请求
/// @param params params description
/// @param url url description
/// @param block block description
+ (void)getRequestWithParams:(NSDictionary *)params url:(NSString *)url block:(RequestEngineBlock)block {
    [self getRequestWithParams:params url:url path:@[] block:block];
}

/// get请求 path
/// @param params params description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)getRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block {
    VVRequestMessage *message = [VVRequestMessage messageWithMethod:GET url:url args:params paths:path];
    VVWeakSelf
    [self doRequest:message isBody:YES callbackBlock:^(VVResponseMessage *responseMessage) {
        VVStrongSelf
        [self checkResponseMessage:responseMessage success:^(BOOL success) {
            if (block) {
                block(success,responseMessage);
            }
        }];
    }];
}

/// put请求 query
/// @param params dictionary description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)putQueryRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block {
    VVRequestMessage *message = [VVRequestMessage messageWithMethod:PUT url:url args:params paths:path];
    VVWeakSelf
    [self doRequest:message isBody:NO callbackBlock:^(VVResponseMessage *responseMessage) {
        VVStrongSelf
        [self checkResponseMessage:responseMessage success:^(BOOL success) {
            if (block) {
                block(success,responseMessage);
            }
        }];
    }];
}

/// put请求 body
/// @param params dictionary description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)putBodyRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block {
    VVRequestMessage *message = [VVRequestMessage messageWithMethod:PUT url:url args:params paths:path];
    VVWeakSelf
    [self doRequest:message isBody:YES callbackBlock:^(VVResponseMessage *responseMessage) {
        VVStrongSelf
        [self checkResponseMessage:responseMessage success:^(BOOL success) {
            if (block) {
                block(success,responseMessage);
            }
        }];
    }];
}
/**
 发送请求
 
 @param message message description
 @param callbackBlock callbackBlock description
 */
+ (void)doRequest:(VVRequestMessage *)message isBody:(BOOL)isBody callbackBlock:(NetworkResponseCallback)callbackBlock {
    AFHTTPSessionManager *manager = [self configueSession];
    
    NSLog(@"\n请求的URL ==== %@\n请求的参数 ==== %@",message.url,message.args);
    __weak typeof(manager) weakManager = manager;
    VVWeakSelf
    switch (message.method) {
        case POST:
        {
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

            NSMutableDictionary * params = @{}.mutableCopy;
            if (message.args) {
                [params setValuesForKeysWithDictionary:message.args];
            }
            NSError *requestError = nil;
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:message.url parameters:nil error:&requestError];
            // body
            NSData *postData = [params.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:postData];
            
            NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                //
            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                //
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                [weakSelf proccessResponse:message operation:nil responseObject:responseObject error:error callbackBlock:callbackBlock];
                [weakManager invalidateSessionCancelingTasks:YES];
            }];
            [task resume];
        }
            break;
        case GET:
        {
             manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
            NSMutableDictionary * params = @{}.mutableCopy;
            if (message.args) {
                [params setValuesForKeysWithDictionary:message.args];
            }
            [manager GET:message.url
              parameters:params
                progress:^(NSProgress * _Nonnull downloadProgress) {}
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [weakSelf proccessResponse:message operation:task responseObject:responseObject error:nil callbackBlock:callbackBlock];
                [weakManager invalidateSessionCancelingTasks:YES];
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf proccessResponse:message operation:task responseObject:nil error:error callbackBlock:callbackBlock];
                [weakManager invalidateSessionCancelingTasks:YES];
            }];
        }
            break;
        case PUT:
        {
            if (isBody) {
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                
                NSMutableDictionary * params = @{}.mutableCopy;
                if (message.args) {
                    [params setValuesForKeysWithDictionary:message.args];
                }
                
                NSError *requestError = nil;
                NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"PUT" URLString:message.url parameters:nil error:&requestError];
                // body
                NSData *postData = [params.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding];
                [request setHTTPBody:postData];
                
                NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                    //
                } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                    //
                } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                    [weakSelf proccessResponse:message operation:nil responseObject:responseObject error:error callbackBlock:callbackBlock];
                    [weakManager invalidateSessionCancelingTasks:YES];
                }];
                [task resume];
            }else {
                NSMutableDictionary * params = @{}.mutableCopy;
                if (message.args) {
                    [params setValuesForKeysWithDictionary:message.args];
                }
                [manager PUT:message.url
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self proccessResponse:message operation:task responseObject:responseObject error:nil callbackBlock:callbackBlock];
                }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self proccessResponse:message operation:task responseObject:nil error:error callbackBlock:callbackBlock];
                }];
            }
        }
            break;
    }
}

/**
 处理数据
 
 @param message message description
 @param operation operation description
 @param responseObject responseObject description
 @param error error description
 @param callbackBlock callbackBlock description
 */
+ (void)proccessResponse:(VVRequestMessage *)message
               operation:(NSURLSessionDataTask *)operation
          responseObject:(id)responseObject
                   error:(NSError *)error
           callbackBlock:(NetworkResponseCallback)callbackBlock {
    VVResponseMessage *responseMessage = [[VVResponseMessage alloc] initWithRequestUrl:message.url requestArgs:message.args];
    responseMessage.responseString = [NSString stringWithFormat:@"%@",operation.response];
    if (responseObject && [responseObject isKindOfClass:NSDictionary.class]) {
        responseMessage.responseObject = responseObject;
        responseMessage.retCode = responseObject[@"code"];
        responseMessage.bussinessData = responseObject[@"data"];
        responseMessage.errorMessage = responseObject[@"msg"];
    }
    NSLog(@"\n请求的URL ==== %@\n请求的参数 ==== %@\n请求结果！responseObject : %@",message.url,message.args,responseObject);
    if (error) {
        NSLog(@"\n请求的URL ==== %@\n请求的参数 ==== %@\n请求出错:%@ + responseString : %@",message.url,message.args,error.userInfo,operation.response);
        responseMessage.responseState = VVResponseFailureFinished;
//        if (!responseMessage.errorMessage.length) {
//            responseMessage.errorMessage = @"网络错误";
//        }
    }else {
        responseMessage.responseState = responseObject == nil ? VVResponseNotFinish : VVResponseSuccessFinished;
    }
    
    if (callbackBlock) {
        callbackBlock(responseMessage);
    }
}

/**
 配置请求头
 
 @return return value description
 */
+ (AFHTTPSessionManager *)configueSession {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    manager.securityPolicy = security;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    NSString *token = [VVMethods vv_valuerForKey:@"token"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    return manager;
}

@end
