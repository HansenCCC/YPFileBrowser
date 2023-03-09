//
//  NSString+YPFileFormat.m
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/11.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import "NSString+YPFileFormat.h"

@implementation NSString (YPFileFormat)

//常见文档格式集合 TXT、DOC、XLS、PPT、DOCX、XLSX、PPTX
+ (NSArray <NSString *> *)fileArchives{
    return @[@"TXT",@"txt",
             @"DOC",@"doc",
             @"XLS",@"xls",
             @"PPT",@"ppt",
             @"DOCX",@"docx",
             @"XLSX",@"xlsx",
             @"PPTX",@"pptx",];
}

//常见图片格式集合 JPG、PNG、PDF、TIFF、SWF
+ (NSArray <NSString *> *)fileImages{
    return @[@"JPG",@"jpg",
             @"JPEG",@"jpeg",
             @"PNG",@"png",
             @"PDF",@"pdf",
             @"TIFF",@"tiff",
             @"SWF",@"swf",];
}

//常见视频格式集合FLV、RMVB、MP4、MVB
+ (NSArray <NSString *> *)fileVideo{
    return @[@"FLV",@"flv",
             @"RMVB",@"rmvb",
             @"MP4",@"mp4",
             @"MVB",@"mvb",
            ];
}

//常见音频格式集合WMA、MP3
+ (NSArray <NSString *> *)fileMusics{
    return @[@"WMA",@"wma",
             @"MP3",@"mp3",];
}

//常见压缩格式集合ZIP RAR
+ (NSArray <NSString *> *)fileZips{
    return @[@"ZIP",@"zip",
             @"RAR",@"rar",
             @"XIP",@"xip",];
}

//常见网站格式集合html
+ (NSArray <NSString *> *)fileWeb{
    return @[@"HTML",@"html",];
}

//常见数据库集合db
+ (NSArray <NSString *> *)fileDatabase{
    return @[@"DB",@"db",
             @"sqlite",@"SQLITE",];
}

@end
