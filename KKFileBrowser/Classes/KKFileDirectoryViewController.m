//
//  KKFileDirectoryViewController.m
//  KKFileBrowser_Example
//
//  Created by Hansen on 2021/8/7.
//  Copyright © 2021 HansenCCC. All rights reserved.
//

#import "KKFileDirectoryViewController.h"
#import "KKFileBrowserCollectionViewCell.h"
#import "KKFileListViewController.h"
#import "KKFileBrowserInfo+KKFileBrowser.h"


@implementation KKFileBrowserInfo

/// 快速初始化
/// @param name 文件名字
/// @param path 路径
- (instancetype)initWithName:(NSString *)name path:(NSString *)path{
    self = [self init];
    if (!self) {
        return nil;
    }
    self.fileName = name;
    self.filePath = path;
    return self;
}

@end


@interface KKFileDirectoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray <KKFileBrowserInfo *>* datum;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation KKFileDirectoryViewController

- (instancetype)initWithPaths:(NSArray <KKFileBrowserInfo *>*)fileInfos{
    self = [self init];
    if (!self) {
        return nil;
    }
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    [paths addObjectsFromArray:@[
        [KKFileBrowserInfo RootDirectory],
        [KKFileBrowserInfo NSHomeDirectory],
        [KKFileBrowserInfo NSDocumentDirectory],
        [KKFileBrowserInfo NSBundleMainDirectory],
    ]];
    [paths addObjectsFromArray:fileInfos];
    self.datum = [paths copy];
    //
    [self setupSubviews];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"文件夹目录";
    NSLog(@"%@",[NSBundle bundleForClass:[self class]]);
}

- (void)setupSubviews{
    [self.collectionView registerClass:[KKFileBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"KKFileBrowserCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect boudns = self.view.bounds;
    CGRect f1 = boudns;
    self.collectionView.frame = f1;
}

#pragma mark - setters

#pragma mark - getters
- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0.f;
        _flowLayout.minimumInteritemSpacing = 0.f;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKFileBrowserInfo *cellModel = self.datum[indexPath.row];
    KKFileBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFileBrowserCollectionViewCell" forIndexPath:indexPath];
    cell.cellModel = cellModel;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datum.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //TODO
    KKFileBrowserInfo *cellModel = self.datum[indexPath.row];
    KKFileListViewController *vc = [[KKFileListViewController alloc] initWithPath:cellModel.filePath];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    size.width = collectionView.frame.size.width;
    size.height = 44.f;
    return size;
}
@end
