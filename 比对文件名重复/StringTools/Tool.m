//
//  Tool.m
//  StringTools
//
//  Created by 郭朝顺 on 2021/3/5.
//

#import "Tool.h"
#import <objc/message.h>


//#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


#define Safe_Block(block, ...) if (block) { block(__VA_ARGS__); };


@interface Tool ()

@property (nonatomic, strong) NSMutableSet *set;
@property (nonatomic, strong) NSMutableSet *set2;


@end


@implementation Tool


+ (void)load {

//    [[self new] getAllFiles:@"/Users/uxin/Desktop/无名高地/比对文件名重复/StringTools"];

//    [[self new] getAllFiles:@"/Users/uxin/Desktop/组件库/热云封装/Example"];
//    [[self new] getAllFiles:@"/Users/uxin/Desktop/pika重复文件"];


}


- (void)getAllFiles:(NSString *)path {

    NSFileManager *fm = [NSFileManager defaultManager];
    // 递归获取到文件夹下的所有的文件
    NSArray *fileNameArray = [fm subpathsOfDirectoryAtPath:path error:nil];
    // 获取文件夹下的一层目录
//    NSArray *fileNameArray = [fm contentsOfDirectoryAtPath:path error:nil];

    for (NSString * fileName in fileNameArray) {

        NSString * name = [fileName lastPathComponent];
        if (![name containsString:@".h"] && ![name containsString:@".m"]) {
            continue;
        }

//        NSLog(@"%@ -- %@",fileName,name);
        if ([self.set containsObject:name]) {
            NSLog(@"重复文件 %@",name);
            [self.set2 addObject:name];
        } else {
            [self.set addObject:name];
        }
    }

    NSLog(@"%@",self.set2);

}

- (BOOL)isDirectory:(NSString *)path {
    BOOL isDir;
    NSFileManager *fm = [NSFileManager defaultManager];
    // 2) 判断是否是一个目录
    [fm fileExistsAtPath:path isDirectory:&isDir];
//    if (isDir) {
//        NSLog(@"这是一个目录");
//    }else{
//        NSLog(@"这不是一个目录");
//    }
    return isDir;
}



- (NSMutableSet *)set {
    if (_set == nil) {
        _set = [NSMutableSet set];
    }
    return _set;
}

- set2 {
    if (_set2 == nil) {
        _set2 = [NSMutableSet set];
    }
    return _set2;
}


@end
