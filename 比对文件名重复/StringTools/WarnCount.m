//
//  WarnCount.m
//  StringTools
//
//  Created by 郭朝顺 on 2022/11/24.
//

#import "WarnCount.h"

#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String] );

@implementation WarnCount


+ (void)load {
//    [self findWarn];
}


+ (void)findWarn {
    NSString *path = @"/Users/uxin/Desktop/无名高地/比对文件名重复/StringTools/warning.txt";
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"warning" ofType:@"txt"];

    NSError *error = nil;
    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"出错了  %@",error);
        return;
    }

    NSArray *array = [str componentsSeparatedByString:@"\n"];

    NSString *space = @"/YCProject/UXLive/UXLive/UXLive/";
    NSString *text = @"warning:";

    NSMutableArray *result = [NSMutableArray array];
    for (NSString *line in array) {

        // 包含警告
        if ([line containsString:space] &&
            [line containsString:text]) {
            // 去掉图片类型警告
            if ([line containsString:@"The image set name"]) {
                continue;
            }
            [result addObject:line];
        }
    }
    NSLog(@"%@",@(result.count));

    for (NSString *warnLine in result) {
        NSLog(@"%@",warnLine);
        NSLog(@"");

    }
}


@end
