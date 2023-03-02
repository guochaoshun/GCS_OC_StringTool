//
//  PodVersionCheck.m
//  StringTools
//
//  Created by 郭朝顺 on 2022/3/15.
//

#import "PodVersionCheck.h"
#import "Header.h"
#import "PodModel.h"

@implementation PodVersionCheck

+ (void)load2 {


    NSArray *kilaArray = [self getPodVersionArrayWithPath:@"/Users/uxin/Desktop/无名高地/比对文件名重复/StringTools/New Group/kila_podfIle.text"];
    NSArray *audioArray = [self getPodVersionArrayWithPath:@"/Users/uxin/Desktop/无名高地/比对文件名重复/StringTools/New Group/audio_podfile.text"];
    NSArray *pikaArray = [self getPodVersionArrayWithPath:@"/Users/uxin/Desktop/无名高地/比对文件名重复/StringTools/New Group/pika_podfile.text"];
//    NSLog(@"%lu %@",kilaArray.count,kilaArray);
//    NSLog(@"---------------");
//    NSLog(@"%lu %@",audioArray.count,audioArray);
//    NSLog(@"---------------");
//    NSLog(@"%lu %@",pikaArray.count,pikaArray);


    kilaArray = [kilaArray sortedArrayUsingComparator:^NSComparisonResult(PodModel *  _Nonnull obj1, PodModel *  _Nonnull obj2) {
        return [obj1.podName compare:obj2.podName];
    }];
    audioArray = [audioArray sortedArrayUsingComparator:^NSComparisonResult(PodModel *  _Nonnull obj1, PodModel *  _Nonnull obj2) {
        return [obj1.podName compare:obj2.podName];
    }];
    pikaArray = [pikaArray sortedArrayUsingComparator:^NSComparisonResult(PodModel *  _Nonnull obj1, PodModel *  _Nonnull obj2) {
        return [obj1.podName compare:obj2.podName];
    }];

//    NSLog(@"%lu %@",kilaArray.count,kilaArray);
//    NSLog(@"---------------");
//    NSLog(@"%lu %@",audioArray.count,audioArray);
//    NSLog(@"---------------");
//    NSLog(@"%lu %@",pikaArray.count,pikaArray);

    NSMutableArray *sameArray = [NSMutableArray array];
    for (PodModel *kilaPod in kilaArray) {
        if ([audioArray containsObject:kilaPod] &&
            [pikaArray containsObject:kilaPod]) {
            [sameArray addObject:kilaPod];
        }
    }
    NSLog(@"3端完全一致的  %lu %@",sameArray.count,sameArray);

//        NSMutableArray *sameArray = [NSMutableArray array];
//        for (PodModel *kilaPod in kilaArray) {
//            if ([audioArray containsObject:kilaPod]) {
//                [sameArray addObject:kilaPod];
//            }
//        }
//        NSLog(@"克拉漫播完全一致的  %lu %@",sameArray.count,sameArray);


}

+ (NSArray *)getPodVersionArrayWithPath:(NSString *)path {
    NSString *podString = [self readFileWithPath:path];
    NSArray *podArray = [podString componentsSeparatedByString:@"\n"];
    NSMutableArray *result = [NSMutableArray array];

    for (NSString *str in podArray) {
        NSString *realStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        // 本行有pod && 本行没有注释掉
        if ([realStr containsString:@"pod"] && [realStr hasPrefix:@"#"] == NO) {
            // realStr =  "pod 'ULAliyunHTTPDNS' , '= 2.0.6'",
            NSArray <NSString *>*tempArray = [realStr componentsSeparatedByString:@"'"];
            PodModel *podModel = [[PodModel alloc] init];
            podModel.podName = tempArray[1];

            NSString *podVersion = [tempArray[tempArray.count-2] stringByReplacingOccurrencesOfString:@"=" withString:@""];
            podVersion = [podVersion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            podModel.podVersion = podVersion;
            [result addObject:podModel];
        }
    }

    return result;
}


+ (NSString *)readFileWithPath:(NSString *)filePath {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *fileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return fileContent;
}


@end
