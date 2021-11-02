//
//  KKFileBrowserInfo.h
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/7.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKFileDirectoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKFileBrowserInfo (KKFileBrowser)

+ (KKFileBrowserInfo *)RootDirectory;//iPhone根文件夹

+ (KKFileBrowserInfo *)NSHomeDirectory;//NSHomeDirectory()
+ (KKFileBrowserInfo *)NSDocumentDirectory;//[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
+ (KKFileBrowserInfo *)NSBundleMainDirectory;//[[NSBundle mainBundle] bundlePath]

@end


NS_ASSUME_NONNULL_END
