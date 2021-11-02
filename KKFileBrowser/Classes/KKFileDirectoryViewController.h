//
//  KKFileDirectoryViewController.h
//  KKFileBrowser_Example
//  文件目录
//  Created by Hansen on 2021/8/7.
//  Copyright © 2021 HansenCCC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKFileBrowserInfo : NSObject

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *fileImageName;
@property (nonatomic, copy) NSDictionary *fileInfo;

/// 快速初始化
/// @param name 文件名字
/// @param path 路径
- (instancetype)initWithName:(NSString *)name path:(NSString *)path;

@end

@interface KKFileDirectoryViewController : UIViewController

/// 标准初始化
/// @param fileInfos @[@{@"fileName":@"文件名字",@"filePath":@"文件路径"}]
- (instancetype)initWithPaths:(NSArray <KKFileBrowserInfo *>*)fileInfos;

@end

NS_ASSUME_NONNULL_END
