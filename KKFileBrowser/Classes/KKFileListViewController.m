//
//  KKFileListViewController.m
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/11.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import "KKFileListViewController.h"
#import "KKFileBrowserInfo+KKFileBrowser.h"
#import "KKFileBrowserCollectionViewCell.h"
#import "NSString+KKFileBrowser.h"
#import "KKQLPreviewController.h"
#import "KKFileBrowserDatabaseTableViewController.h"


typedef enum : NSUInteger {
    KKFileBrowserDefaultStyle,
    KKFileBrowserWindowsStyle,
} KKFileBrowserStyle;

static NSString *const KNSUserDefaultsFileBrowserStyle = @"KNSUserDefaultsFileBrowserStyle";

@interface KKFileListViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) NSMutableArray <KKFileBrowserInfo *> *datum;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) KKFileBrowserStyle fileBrowserStyle;

@end

@implementation KKFileListViewController

- (instancetype)initWithPath:(NSString *)path{
    self = [self init];
    if (!self) {
        return nil;
    }
    self.filePath = path;
    self.title = [self.filePath pathComponents].lastObject;
    self.datum = [[NSMutableArray alloc] init];
    //
    [self setupSubviews];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(rightClickAction)];
    [self reloadDatum];
    [self addNotificationObserver];
}

- (void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenChangeFileBrowserStyle) name:KNSUserDefaultsFileBrowserStyle object:nil];
}

- (void)whenChangeFileBrowserStyle{
    [self reloadDatum];
    [self viewWillLayoutSubviews];
}

- (void)rightClickAction{
    //TODO
    if (self.fileBrowserStyle == KKFileBrowserDefaultStyle) {
        self.fileBrowserStyle = KKFileBrowserWindowsStyle;
    } else if(self.fileBrowserStyle == KKFileBrowserWindowsStyle){
        self.fileBrowserStyle = KKFileBrowserDefaultStyle;
    }
}

- (void)reloadDatum{
    [self.datum removeAllObjects];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = self.filePath;
    NSArray *tempArray = [manager contentsOfDirectoryAtPath:path error:nil];
    tempArray = [tempArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    for (NSString *item in tempArray) {
        NSString *currentPath = [path stringByAppendingPathComponent:item];
        NSDictionary *reslut = [manager attributesOfItemAtPath:currentPath error:nil];
        BOOL isDir;
        [manager fileExistsAtPath:currentPath isDirectory:&isDir];
        NSString *value;
        NSString *imageName;
        if (isDir) {
            //文件夹
            NSArray *tempArray = [manager contentsOfDirectoryAtPath:currentPath error:nil];
            value = [NSString stringWithFormat:@"%@ 个项目",@(tempArray.count).stringValue];
        }else{
            //文件
            double byte = 1000.0;
            long fileSize = reslut.fileSize/byte;
            double fileSizeTmp;
            NSString *tip;
            if (fileSize > byte * byte) {
                tip = @"GB";
                fileSizeTmp = fileSize/(byte * byte);
            }else if(fileSize > byte){
                tip = @"MB";
                fileSizeTmp = fileSize/(byte);
            }else{
                tip = @"KB";
                fileSizeTmp = fileSize;
            }
            value = [NSString stringWithFormat:@"%.2f %@",fileSizeTmp,tip];
            //
            NSString *pathExtension = [currentPath pathExtension];
            if ([[NSString fileZips] containsObject:pathExtension]) {
                //压缩包
                imageName = @"kk_icon_fileZip.png";
            }else if ([[NSString fileVideo] containsObject:pathExtension]) {
                //视频
                imageName = @"kk_icon_fileVideo.png";
            }else if ([[NSString fileImages] containsObject:pathExtension]) {
                //图片
                imageName = @"kk_icon_fileImage.png";
            }else if ([[NSString fileMusics] containsObject:pathExtension]) {
                //音乐
                imageName = @"kk_icon_fileMusic.png";
            }else if ([[NSString fileArchives] containsObject:pathExtension]) {
                //文档
                imageName = @"kk_icon_fileTxt.png";
            }else if ([[NSString fileWeb] containsObject:pathExtension]) {
                //文档
                imageName = @"kk_icon_fileWeb.png";
            }else {
                //未知类型
                imageName = @"kk_icon_fileUnknow.png";
            }
        }
        KKFileBrowserInfo *element = [[KKFileBrowserInfo alloc] init];
        element.fileName = item;
        element.fileSize = value;
        element.fileInfo = reslut;
        element.fileImageName = imageName;
        element.filePath = [NSString stringWithFormat:@"%@/%@",self.filePath,item];
        [self.datum addObject:element];
    }
    [self.collectionView reloadData];
}

- (void)setupSubviews{
    [self.collectionView registerClass:[KKFileBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"KKFileBrowserCollectionViewCell"];
    [self.collectionView registerClass:[KKFileBrowserWindowsCollectionViewCell class] forCellWithReuseIdentifier:@"KKFileBrowserWindowsCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect boudns = self.view.bounds;
    CGRect f1 = boudns;
    self.collectionView.frame = f1;
    //
    if (self.fileBrowserStyle == KKFileBrowserDefaultStyle) {
        CGFloat space = 0.f;//间隙
        CGSize itemSize = CGSizeZero;
        itemSize.width = self.collectionView.frame.size.width;
        itemSize.height = 44.f;
        self.flowLayout.itemSize = itemSize;
        self.flowLayout.minimumInteritemSpacing = 0.f;
        self.flowLayout.minimumLineSpacing = 0.f;
        self.flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    } else if(self.fileBrowserStyle == KKFileBrowserWindowsStyle){
        CGFloat space = 10.f;//间隙
        NSInteger count = 4;//一行显示个数
        CGRect bounds = self.view.bounds;
        CGSize itemSize = CGSizeZero;
        itemSize.width = (bounds.size.width - (count + 2) * space)/count;
        itemSize.height = itemSize.width + 60.f;
        self.flowLayout.itemSize = itemSize;
        self.flowLayout.minimumLineSpacing = space;
        self.flowLayout.minimumInteritemSpacing = space;
        self.flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    }
}

#pragma mark - setters
- (void)setFileBrowserStyle:(KKFileBrowserStyle)fileBrowserStyle{
    [[NSUserDefaults standardUserDefaults] setInteger:fileBrowserStyle forKey:KNSUserDefaultsFileBrowserStyle];
    //发送修改通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KNSUserDefaultsFileBrowserStyle object:nil];
}

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
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (KKFileBrowserStyle)fileBrowserStyle{
    KKFileBrowserStyle fileBrowserStyle = [[NSUserDefaults standardUserDefaults] integerForKey:KNSUserDefaultsFileBrowserStyle];
    return fileBrowserStyle;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.fileBrowserStyle == KKFileBrowserDefaultStyle) {
        KKFileBrowserInfo *cellModel = self.datum[indexPath.row];
        KKFileBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFileBrowserCollectionViewCell" forIndexPath:indexPath];
        cell.cellModel = cellModel;
        return cell;
    } else if(self.fileBrowserStyle == KKFileBrowserWindowsStyle){
        KKFileBrowserInfo *cellModel = self.datum[indexPath.row];
        KKFileBrowserWindowsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFileBrowserWindowsCollectionViewCell" forIndexPath:indexPath];
        cell.cellModel = cellModel;
        return cell;
    } else {
        return [[UICollectionViewCell alloc] init];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datum.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //TODO
    NSFileManager *manager = [NSFileManager defaultManager];
    KKFileBrowserInfo *cellModel = self.datum[indexPath.row];
    BOOL isDir;
    [manager fileExistsAtPath:cellModel.filePath isDirectory:&isDir];
    if (isDir) {
        //文件夹
        KKFileListViewController *vc = [[KKFileListViewController alloc] initWithPath:cellModel.filePath];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        //判断文件是否是数据库
        NSArray *dbSuffix = [NSString fileDatabase];
        NSString *pathExtension = cellModel.filePath.pathExtension;
        if ([dbSuffix containsObject:pathExtension]) {
            //
            KKFileBrowserDatabaseTableViewController *vc = [[KKFileBrowserDatabaseTableViewController alloc] init];
            vc.path = cellModel.filePath;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            //TODO
            KKQLPreviewController *quickLookVC = [[KKQLPreviewController alloc] init];
            quickLookVC.delegate = self;
            quickLookVC.dataSource = self;
            quickLookVC.currentPreviewItemIndex = indexPath.row;
            [self presentViewController:quickLookVC animated:YES completion:nil];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - QLPreviewControllerDelegate, QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
   return self.datum.count;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    KKFileBrowserInfo *cellModel = self.datum[index];
    NSURL *url = [NSURL fileURLWithPath:cellModel.filePath];
    return url;
}

@end
