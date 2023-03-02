//
//  PodModel.m
//  StringTools
//
//  Created by 郭朝顺 on 2022/3/15.
//

#import "PodModel.h"

@implementation PodModel

- (NSString *)debugDescription {
    return [self description];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@",self.podName,self.podVersion];
}

- (BOOL)isEqual:(id)object {
    if ([object isMemberOfClass:[PodModel class]]) {
        PodModel *obj = object;
        if ([obj.podName isEqualToString:self.podName] &&
            [obj.podVersion isEqualToString:self.podVersion]) {
            return YES;
        }
    }

    return NO;

}




@end
