//
//  YPFileInfo.h
//  YPFileBrowser
//
//  Created by Hansen on 2023/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPFileInfo : NSObject

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *fileSize;
@property (nonatomic, strong) NSString *fileImageName;
@property (nonatomic, strong) NSDictionary *fileInfo;

- (instancetype)initWithName:(NSString *)name path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
