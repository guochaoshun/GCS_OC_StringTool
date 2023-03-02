//
//  Header.h
//  StringTools
//
//  Created by 郭朝顺 on 2022/3/15.
//

#ifndef Header_h
#define Header_h


#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String] );


#endif /* Header_h */
