//
//  UIImage+YPFileBrowser.m
//  KKFileBrowser
//
//  Created by shinemo on 2021/8/12.
//

#import "UIImage+YPResource.h"
#import "YPFileInfo.h"

@implementation UIImage (YPResource)

+ (UIImage *)yp_imageWithBundleImageNamed:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[YPFileInfo class]];
    NSString *filePath = [bundle pathForResource:name ofType:nil inDirectory:@"YPFileBrowser.bundle"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end
