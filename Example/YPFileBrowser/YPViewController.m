//
//  YPViewController.m
//  YPFileBrowser
//
//  Created by 18319825 on 03/08/2023.
//  Copyright (c) 2023 18319825. All rights reserved.
//

#import "YPViewController.h"
#import <YPFileBrowser/YPFileBrowser.h>

@interface YPViewController ()

@property (nonatomic, strong) UIButton *showButton;

@end

@implementation YPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点击下面按钮";
    self.showButton = [[UIButton alloc] init];
    [self.showButton addTarget:self action:@selector(showButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.showButton setTitle:@"展示" forState:UIControlStateNormal];
    self.showButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.showButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size = CGSizeMake(100.f, 30.f);
    f1.origin.x = (bounds.size.width - f1.size.width) / 2.f;
    f1.origin.y = (bounds.size.height - f1.size.height) / 2.f;
    self.showButton.frame = f1;
}

- (void)showButtonAction:(UIButton *)sender {
    YPFileBrowser *list = [[YPFileBrowser alloc] initWithPath:@"/"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:list];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
