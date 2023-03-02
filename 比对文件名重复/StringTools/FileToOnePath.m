//
//  FileToOnePath.m
//  StringTools
//
//  Created by 郭朝顺 on 2023/1/18.
//

#import "FileToOnePath.h"

/// 要处理的文件夹路径
static NSString *const FileToOnePathDirectoryPath = @"/Users/uxin/Downloads/Classes";


@implementation FileToOnePath

+ (void)load {

//    [self fileToOnePath];
}

// 文件挪到一个目录下
+ (void)fileToOnePath {

    NSString *filePath = FileToOnePathDirectoryPath;
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!fileExist) {
        NSLog(@"文件不存在,结束");
    }

    NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:filePath];
    NSLog(@"%@",array);

    for (NSString *path in array) {

        NSString *fullPath = [filePath stringByAppendingPathComponent:path];

        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir];
        /// 是文件夹, 不用处理,后面统一删除
        if (isDir) {
            continue;
        }

        // 是文件
        NSError *error = nil;
        NSString *toPath = [filePath stringByAppendingPathComponent:path.lastPathComponent];
        [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toPath error:&error];
        if (error) {
            NSLog(@"出错了 %@ ",error);
        } else {
            NSLog(@"挪动成功 %@ %@",fullPath,toPath);
        }
    }

    for (NSString *path in array) {

        NSString *fullPath = [filePath stringByAppendingPathComponent:path];

        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir];
        /// 是文件夹, 不用处理,后面统一删除
        if (isDir) {
            [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
        }
    }

}



@end
