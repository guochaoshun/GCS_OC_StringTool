//
//  MethodContain.m
//  StringTools
//
//  Created by 郭朝顺 on 2022/3/14.
//

#import "MethodContain.h"
#import "Header.h"

@implementation MethodContain


+ (void)load {
//    [self methodCheck];
}

+ (void)methodCheck {
    NSString *protoalMethod = [self readFileWithPath:@"/Users/uxin/Desktop/无名高地/比对文件名重复/StringTools/methodList.text"];
    NSArray *array = [protoalMethod componentsSeparatedByString:@"\n"];
    NSMutableArray *methodArray = [NSMutableArray array];
    for (NSString *str in array) {
        if (str.length > 0) {
            NSString *methodStr = [self hanelStringToMethod:str];
            [methodArray addObject:methodStr];
        }
    }
    NSString *impString = [self readFileWithPath:@"/Users/uxin/Desktop/kila_repo/UXLive/UXLive/UXLive/ULShareFeatures/ULLive/UI/ULPlayback/ViewControllers/ULLivePlayBackViewController.m"];
    for (NSString *method in methodArray) {

        if ([impString containsString:method]) {

        } else {
            if (method.length > 0) {
                NSLog(@"%@ 不包含,请检查",method);
            }
        }
    }
}

+ (NSString *)hanelStringToMethod:(NSString *)originStr {
    NSString *result = @"";
    if ([originStr containsString:@")"] && [originStr containsString:@";"]) {
        originStr = [originStr stringByReplacingOccurrencesOfString:@";" withString:@""];
        NSRange location = [originStr rangeOfString:@")"];
        result = [originStr substringFromIndex:location.location+location.length];
    }
    return result;
}


+ (NSString *)readFileWithPath:(NSString *)filePath {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *fileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return fileContent;
}


@end


/*

 现在的直播间有实现, 回放直播间未实现, 旧版的回放直播间也没有实现的方法


 /// 点击上墙头像或者名字  回放没有上墙
 - (void)giftManagerUpWallToastManagerClickAvatarOrNameWithSenderId:(ULLInteger)senderId;

//  气泡状态发生变化, 更新本地的气泡记录,回放无IM,不需要更新,下次进直播间会重新拉取
 - (void)giftManagerBubbleStatusChanged:(ULLiveBackpackGoods *)goods;

 /// 展示了背包、礼物面板、招财猫礼物引导  回放无礼物引导
 /// @param panelView panelView
 /// @param guideView guideView
 - (void)giftManagerShowBackpackGiftGuideView:(ULGameGuideView *)guideView;

 /// 背包送礼 点击事件回调   只是埋点,无逻辑
 /// @param clickEventType 事件类型
 - (void)giftManagerBackpackGiftClickEventType:(ULBackpackGiftClickEventType)clickEventType;


 /// 获取用户是否是守护团成员,  回放无守护团逻辑
 - (BOOL)giftManagerUserIsBuyFansGroup;

 /// 弹窗提示用户加入守护团, 回放无守护团逻辑
 - (void)giftManagerShowAlertToJoinFansGroup;

 */
