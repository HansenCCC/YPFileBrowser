//
//  KKFileBrowserInfo.m
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/7.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import "KKFileBrowserInfo+KKFileBrowser.h"

@implementation KKFileBrowserInfo (KKFileBrowser)

+ (KKFileBrowserInfo *)RootDirectory{
    return [[KKFileBrowserInfo alloc] initWithName:@"System根目录" path:@"/"];
}

+ (KKFileBrowserInfo *)NSHomeDirectory{
    return [[KKFileBrowserInfo alloc] initWithName:@"NSHomeDirectory()目录" path:NSHomeDirectory()];
}

+ (KKFileBrowserInfo *)NSDocumentDirectory{
    return [[KKFileBrowserInfo alloc] initWithName:@"Document目录" path:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
}

+ (KKFileBrowserInfo *)NSBundleMainDirectory{
    return [[KKFileBrowserInfo alloc] initWithName:@"MainBundle目录" path:[[NSBundle mainBundle] bundlePath]];
}

@end
