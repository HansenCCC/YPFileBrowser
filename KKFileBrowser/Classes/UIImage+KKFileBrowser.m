//
//  UIImage+KKFileBrowser.m
//  KKFileBrowser
//
//  Created by shinemo on 2021/8/12.
//

#import "UIImage+KKFileBrowser.h"
#import "KKFileBrowserInfo+KKFileBrowser.h"

@implementation UIImage (KKFileBrowser)

+ (UIImage *)kk_fileBrowserBundleImageNamed:(NSString *)name{
    NSBundle *bundle = [NSBundle bundleForClass:[KKFileBrowserInfo class]];
    NSString *filePath = [bundle pathForResource:name ofType:nil inDirectory:@"KKFileBrowser.bundle"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end
