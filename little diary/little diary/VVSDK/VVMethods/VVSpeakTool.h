//
//  VVSpeakTool.h
//  Italy
//
//  Created by wangyang on 2020/3/23.
//  Copyright © 2020 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 汉语:          zh-CN      (普通话)
 粤语:          zh-HK
 英语:          en-US
 俄语:          ru-RU
 日语:          ja-JP
 泰语:          th-TH
 德语:          de-DE
 韩语:          ko-KO
 法语:          fr-FR
 希腊语:         gr-GR
 意大利语:       it-IT
 西班牙语:       es-ES
 阿拉伯语:       ar-Ar
 葡萄牙语:       pt-PT
 */
typedef enum : NSUInteger {
    VV_ZH_CN = 0,//汉语
    VV_ZH_HK,//粤语
    VV_EN_US,//英语
    VV_RU_RU,//俄语
    VV_JP_JP,//日语
    VV_TH_TH,//泰语
    VV_DE_DE,//德语
    VV_KO_KO,//韩语
    VV_FR_FR,//法语
    VV_GR_GR,//希腊语
    VV_IT_IT,//意大利语
    VV_ES_ES,//西班牙语
    VV_AR_AR,//阿拉伯语
    VV_PT_PT,//葡萄牙语
} VVLanguageType;

@interface VVSpeakTool : NSObject

//声音大小
@property(nonatomic,copy) NSString *volume;           // [0-1] Default = 1

+ (instancetype)shareInstance;

+ (instancetype)shareInstanceWithLanguageType:(VVLanguageType)languageType
                                         rate:(CGFloat)rate
                                       volume:(CGFloat)volume;

/**
 播放文本

 @param playText playText description
 */
- (void)playText:(NSString *)playText;

//停止播放
- (void)stopSpeaking;

//暂停播放
- (void)pauseSpeaking;

//继续播放
- (void)continueSpeaking;

@end
NS_ASSUME_NONNULL_END
