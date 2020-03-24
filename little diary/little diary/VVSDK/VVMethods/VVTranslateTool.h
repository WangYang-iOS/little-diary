//
//  VVTranslateTool.h
//  Italy
//
//  Created by wangyang on 2020/3/23.
//  Copyright © 2020 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    VVT_ZH_CN = 0,//汉语
    VVT_ZH_HK,//粤语
    VVT_EN_US,//英语
    VVT_RU_RU,//俄语
    VVT_JP_JP,//日语
    VVT_TH_TH,//泰语
    VVT_DE_DE,//德语
    VVT_KO_KO,//韩语
    VVT_FR_FR,//法语
    VVT_GR_GR,//希腊语
    VVT_IT_IT,//意大利语
    VVT_ES_ES,//西班牙语
    VVT_AR_AR,//阿拉伯语
    VVT_PT_PT,//葡萄牙语
} VVTranslate_LanguageType;

@interface VVTranslateTool : NSObject

+ (void)translateZHToARA:(NSString *)ZHStr callback:(void (^)(BOOL success, NSString *result))callback;

+ (void)translateLanguage:(NSInteger)language
                      str:(NSString *)str
                 callback:(void (^)(BOOL success, NSString *result))callback;
@end

NS_ASSUME_NONNULL_END
