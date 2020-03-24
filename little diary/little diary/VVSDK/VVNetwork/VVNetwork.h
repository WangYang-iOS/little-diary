//
//  VVNetwork.h
//  youleyixia
//
//  Created by wangyang on 2019/12/16.
//  Copyright © 2019 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    VVResponseNotFinish,
    VVResponseSuccessFinished,
    VVResponseFailureFinished
} VVResponseState;

@interface VVResponseMessage : NSObject

@property(strong, nonatomic) NSString *requestUrl;//请求的url,返回方便调试
@property(strong, nonatomic) NSDictionary *requestArgs;//请求时的参数,返回方便调试
@property(strong, nonatomic) NSString *responseString;//返回的原始字符串
@property(assign, nonatomic) NSInteger statusCode;//请求响应状态
@property(assign, nonatomic) VVResponseState responseState;//请求响应状态
@property(strong, nonatomic) id responseObject;//返回处理后的对象，一般为json格式

@property(strong, nonatomic) NSString *retCode;//服务端返回的状态码，0表示成功，其他为失败
@property(strong, nonatomic) NSString *errorMessage;//服务端处理失败时，返回的错误消息
@property(strong, nonatomic) id bussinessData;//在处理成功时服务端返回的的业务数据对象，根据接口的定义确定具体的类型

- (instancetype)initWithRequestUrl:(NSString *)requestUrl requestArgs:(NSDictionary *)requestArgs;

@end

typedef enum{
    POST,
    GET,
    PUT
} VVHttpMethod;

@interface VVRequestMessage : NSObject

@property(strong, nonatomic) NSString *domainURL;//请求的域名 + url;
@property(strong, nonatomic) NSString *url;//请求的url
@property(assign, nonatomic) VVHttpMethod method;//请求method,默认post
@property(strong, nonatomic) NSDictionary *args;//请求时的参数
@property(strong, nonatomic) NSArray *paths;

- (id)initWithUrl:(NSString *)url args:(NSDictionary *)args;

- (id)initWithUrl:(NSString *)url method:(VVHttpMethod)method args:(NSDictionary *)args;
- (id)initWithUrl:(NSString *)url method:(VVHttpMethod)method args:(NSDictionary *)args paths:(NSArray *)paths;
- (id)initMutipartRequestWithUrl:(NSString *)url args:(NSDictionary *)args;

+ (VVRequestMessage *)messageWithMethod:(VVHttpMethod)method url:(NSString *)url args:(NSDictionary *)args paths:(NSArray *)paths;

@end

typedef void (^RequestEngineBlock)(BOOL success, VVResponseMessage *responseMessage);
typedef void (^RequestEngineCheckIsSuccess)(BOOL success);

@interface VVNetwork : NSObject

/// post请求
/// @param params params description
/// @param url url description
/// @param block block description
+ (void)postRequestWithParams:(NSDictionary *)params url:(NSString *)url block:(RequestEngineBlock)block;

/// post请求 path
/// @param params dictionary description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)postRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block;

/// get请求
/// @param params params description
/// @param url url description
/// @param block block description
+ (void)getRequestWithParams:(NSDictionary *)params url:(NSString *)url block:(RequestEngineBlock)block;

/// get请求 path
/// @param params params description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)getRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block;

/// put请求 query
/// @param params dictionary description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)putQueryRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block;

/// put请求 body
/// @param params dictionary description
/// @param url url description
/// @param path path description
/// @param block block description
+ (void)putBodyRequestWithParams:(NSDictionary *)params url:(NSString *)url path:(NSArray *)path block:(RequestEngineBlock)block;

@end

NS_ASSUME_NONNULL_END
