//
//  VVSpeakTool.m
//  Italy
//
//  Created by wangyang on 2020/3/23.
//  Copyright © 2020 wy. All rights reserved.
//

#import "VVSpeakTool.h"
#import <AVFoundation/AVFoundation.h>

@interface VVSpeakTool ()
//所需的源语言
@property (nonatomic,assign) VVLanguageType languageType;
//播放速度
@property (nonatomic,copy) NSString *rate;
@property (nonatomic,strong) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation VVSpeakTool

+ (instancetype)shareInstance {
    
    CGFloat rate = [[[NSUserDefaults standardUserDefaults] valueForKey:@"wyRate"] floatValue];
    CGFloat volume = [[[NSUserDefaults standardUserDefaults] valueForKey:@"wyVolume"] floatValue];

    if (rate == 0) {
        rate = 0.5;
        [[NSUserDefaults standardUserDefaults] setValue:@(rate) forKey:@"wyRate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (volume == 0) {
        volume = 0.5;
        [[NSUserDefaults standardUserDefaults] setValue:@(volume) forKey:@"wyVolume"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return [self shareInstanceWithLanguageType:VV_AR_AR rate:rate volume:volume];
}

+ (instancetype)shareInstanceWithLanguageType:(VVLanguageType)languageType
                                         rate:(CGFloat)rate
                                       volume:(CGFloat)volume {
    static VVSpeakTool *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[VVSpeakTool alloc] init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error;
        if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
            //NSLog(@"Category Error: %@", [error localizedDescription]);
        }
        if (![session setActive:YES error:&error]) {
            //NSLog(@"Activation Error: %@", [error localizedDescription]);
        }
    });
    tools.languageType = languageType;
    tools.rate = [NSString stringWithFormat:@"%f",rate];
    tools.volume = [NSString stringWithFormat:@"%f",volume];
    return tools;
}

/**
 播放文本
 
 @param playText playText description
 */
- (void)playText:(NSString *)playText {
    if (self.speechSynthesizer.isSpeaking) {
        [self stopSpeaking];
    }
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:playText];
    utterance.rate = [self.rate floatValue];
    utterance.volume = [self.volume floatValue];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:[VVSpeakTool languageCode:self.languageType]];
    [self.speechSynthesizer speakUtterance:utterance];
}

//停止播放
- (void)stopSpeaking {
    if (self.speechSynthesizer.isSpeaking) {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

//暂停播放
- (void)pauseSpeaking {
    [self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

//继续播放
- (void)continueSpeaking {
    [self.speechSynthesizer continueSpeaking];
}

+ (NSString *)languageCode:(VVLanguageType)languageType {
    NSString *languageCode = @"";
    switch (languageType) {
        case VV_ZH_CN:
            languageCode = @"zh-CN";
            break;
        case VV_ZH_HK:
            languageCode = @"zh-HK";
            break;
        case VV_EN_US:
            languageCode = @"en-US";
            break;
        case VV_RU_RU:
            languageCode = @"ru-RU";
            break;
        case VV_JP_JP:
            languageCode = @"ja-JP";
            break;
        case VV_TH_TH:
            languageCode = @"th-TH";
            break;
        case VV_DE_DE:
            languageCode = @"de-DE";
            break;
        case VV_KO_KO:
            languageCode = @"ko-KO";
            break;
        case VV_FR_FR:
            languageCode = @"fr-FR";
            break;
        case VV_GR_GR:
            languageCode = @"gr-GR";
            break;
        case VV_IT_IT:
            languageCode = @"it-IT";
            break;
        case VV_ES_ES:
            languageCode = @"es-ES";
            break;
        case VV_AR_AR:
            languageCode = @"ar-SA";
            break;
        case VV_PT_PT:
            languageCode = @"pt-PT";
            break;
            
        default:
            break;
    }
    return languageCode;
}

#pragma mark -
#pragma mark - lazy

- (AVSpeechSynthesizer *)speechSynthesizer {
    if (_speechSynthesizer == nil) {
        _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return _speechSynthesizer;
}

@end
