//
//  YPFileInfo.m
//  YPFileBrowser
//
//  Created by Hansen on 2023/3/8.
//

#import "YPFileInfo.h"

@implementation YPFileInfo

- (instancetype)initWithName:(NSString *)name path:(NSString *)path {
    self = [self init];
    if (!self) {
        return nil;
    }
    self.fileName = name;
    self.filePath = path;
    return self;
}

@end
