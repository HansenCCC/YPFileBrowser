//
//  YPAppDelegate.m
//  YPFileBrowser
//
//  Created by 18319825 on 03/08/2023.
//  Copyright (c) 2023 18319825. All rights reserved.
//

#import "YPAppDelegate.h"
#import "YPViewController.h"

@implementation YPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    YPViewController *vc = [[YPViewController alloc] init];
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = root;
    [self.window makeKeyWindow];
    return YES;
}

@end
