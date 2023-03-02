//
//  FindAllChineseLog.m
//  StringTools
//
//  Created by 郭朝顺 on 2023/3/2.
//

#import "FindAllChineseLog.h"
#import "Header.h"

/// 要处理的文件夹路径
static NSString *const FindAllChineseLogDirectoryPath = @"/Users/uxin/Desktop/GitHub";

@interface FindAllChineseLog ()

@property (nonatomic, assign) NSInteger lineNum;

@property (nonatomic, strong) NSArray *logStrArray;

@end


@implementation FindAllChineseLog

+ (void)load {
    FindAllChineseLog *tool = [[FindAllChineseLog alloc] init];
    [tool findAllChineseLog];
}

// 文件挪到一个目录下
- (void)findAllChineseLog {

    NSString *filePath = FindAllChineseLogDirectoryPath;
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!fileExist) {
        NSLog(@"文件不存在,结束");
    }

    NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:filePath];

    for (NSString *path in array) {

        NSString *fullPath = [filePath stringByAppendingPathComponent:path];

        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir];
        /// 是文件夹, 不用处理,后面统一删除
        if (isDir) {
            continue;
        }


        // 是.m文件, 其他文件不可能存在中文日志
        if ([path.lastPathComponent containsString:@".m"]) {
            [self handleFile:fullPath];
        }


    }
}

- (void)handleFile:(NSString *)filePath {
    @autoreleasepool {

        NSError * error = nil;
        NSString *str = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"出错了, %@ %@",filePath,error);
        }

        NSArray *array = [str componentsSeparatedByString:@"\n"];
        [array enumerateObjectsUsingBlock:^(NSString *  lineStr, NSUInteger idx, BOOL * _Nonnull stop) {
            lineStr = [lineStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([self checkLineStr:lineStr]) {
                NSLog(@"%zd %@ %@",self.lineNum,filePath,lineStr);
                self.lineNum ++;
            }

        }];


    }


}

/// 1.包含log,  2.没有被注释 3.有中文
- (BOOL)checkLineStr:(NSString *)lineStr {
    if ([lineStr containsString:@"Log"]) {

        for (NSString *logStr in self.logStrArray) {
            // 包含log
            if ([lineStr containsString:logStr]) {
                // 2.没有被注释
                if ([lineStr hasPrefix:@"//"] == NO) {
                    // 3. 有中文
                    if ([self containChinese:lineStr]) {
                        return YES;
                    }
                }
            }
        }
    }

    return NO;
}


- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++) { int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)logStrArray {

    if (_logStrArray == nil) {
        _logStrArray =@[
            @"NSLog(",
            @"ULLogInfo(",
            @"ULLogDebug(",
            @"ULLogError(",
            @"ULIMModuleLog(",
            @"ULHttpLog(",
            @"ULImageTimeLog(",
            @"ULHttpTimeLog(",
            @"ULMicLog(",
            @"ULVirtualModelLog(",
            @"ULCameraPreviewLog(",
            @"ULLiveEngineLog(",
            @"ULFaceAssembleLog(",
            @"ULResourceDownloadLog(",
            @"ULAnalyticsLog(",
            @"ULUserOperationLog(",
            @"ULInAppPurchaseLog(",
            @"ULLiveLog(",
            @"ULRadioDramaLog(",
            @"ULPlayerLog(",
            @"ULGiftLog(",
            @"ULDebugLog(",
        ];
    }
    return _logStrArray;
}

@end
