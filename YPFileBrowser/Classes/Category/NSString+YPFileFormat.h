//
//  NSString+YPFileFormat.h
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/11.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YPFileFormat)

/// 常见文档格式集合 TXT、DOC、XLS、PPT、DOCX、XLSX、PPTX
+ (NSArray <NSString *> *)fileArchives;

/// 常见图片格式集合 JPG、PNG、PDF、TIFF、SWF
+ (NSArray <NSString *> *)fileImages;

/// 常见视频格式集合FLV、RMVB、MP4、MVB
+ (NSArray <NSString *> *)fileVideo;

/// 常见音频格式集合WMA、MP3
+ (NSArray <NSString *> *)fileMusics;

/// 常见压缩格式集合ZIP RAR
+ (NSArray <NSString *> *)fileZips;

/// 常见网站格式集合html
+ (NSArray <NSString *> *)fileWeb;

/// 常见数据库集合db
+ (NSArray <NSString *> *)fileDatabase;

@end

NS_ASSUME_NONNULL_END
