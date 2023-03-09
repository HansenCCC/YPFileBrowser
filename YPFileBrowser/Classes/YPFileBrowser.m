//
//  YPFileBrowser.m
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/11.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import "YPFileBrowser.h"
#import "YPFileInfo.h"
#import "YPFileBrowserElementCell.h"
#import "NSString+YPFileFormat.h"
#import "YPBaseQLPreviewController.h"

typedef enum : NSUInteger {
    YPFileBrowserStyleThumbnail, // 图片缩略图展示
    YPFileBrowserStyleList // 纯文本列表展示
} YPFileBrowserStyle;

static NSString *const kNotificationFileBrowserViewModeChange = @"kNotificationFileBrowserViewModeChange";

@interface YPFileBrowser () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
 QLPreviewControllerDataSource, QLPreviewControllerDelegate >

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) YPFileBrowserStyle style;
@property (nonatomic, assign) BOOL isRoot;/// 是否是根试图

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray <YPFileInfo *> *dataList;

@end

@implementation YPFileBrowser

- (instancetype)initWithPath:(NSString *)path {
    self = [self init];
    if (!self) {
        return nil;
    }
    self.isRoot = YES;
    self.filePath = path;
    self.title = [self.filePath pathComponents].lastObject;
    self.dataList = [[NSMutableArray alloc] init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addNotificationObserver];
    [self setupNavigationItem];
    [self setupSubviews];
    [self reloadDatas];
}

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(rightClickAction:)];
    if (self.isRoot) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leftClickAction:)];
    }
}

- (void)rightClickAction:(id)sender {
    if (self.style == YPFileBrowserStyleList) {
        self.style = YPFileBrowserStyleThumbnail;
    } else if(self.style == YPFileBrowserStyleThumbnail){
        self.style = YPFileBrowserStyleList;
    }
}

- (void)leftClickAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStyle) name:kNotificationFileBrowserViewModeChange object:nil];
}

- (void)didChangeStyle {
    [self reloadDatas];
    [self viewWillLayoutSubviews];
}

- (void)reloadDatas {
    [self.dataList removeAllObjects];
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
            /// 文件夹
            NSArray *tempArray = [manager contentsOfDirectoryAtPath:currentPath error:nil];
            value = [NSString stringWithFormat:@"%@ 个项目",@(tempArray.count).stringValue];
        } else{
            /// 文件
            double byte = 1000.0;
            long fileSize = reslut.fileSize/byte;
            double fileSizeTmp;
            NSString *tip;
            if (fileSize > byte * byte) {
                tip = @"GB";
                fileSizeTmp = fileSize/(byte * byte);
            } else if (fileSize > byte) {
                tip = @"MB";
                fileSizeTmp = fileSize/(byte);
            } else {
                tip = @"KB";
                fileSizeTmp = fileSize;
            }
            value = [NSString stringWithFormat:@"%.2f %@",fileSizeTmp,tip];
            //
            NSString *pathExtension = [currentPath pathExtension];
            if ([[NSString fileZips] containsObject:pathExtension]) {
                /// 压缩包
                imageName = @"yp_icon_fileZip.png";
            }else if ([[NSString fileVideo] containsObject:pathExtension]) {
                /// 视频
                imageName = @"yp_icon_fileVideo.png";
            }else if ([[NSString fileImages] containsObject:pathExtension]) {
                /// 图片
                imageName = @"yp_icon_fileImage.png";
            }else if ([[NSString fileMusics] containsObject:pathExtension]) {
                /// 音乐
                imageName = @"yp_icon_fileMusic.png";
            }else if ([[NSString fileArchives] containsObject:pathExtension]) {
                /// 文档
                imageName = @"yp_icon_fileTxt.png";
            }else if ([[NSString fileWeb] containsObject:pathExtension]) {
                /// 文档
                imageName = @"yp_icon_fileWeb.png";
            }else {
                /// 未知类型
                imageName = @"yp_icon_fileUnknow.png";
            }
        }
        YPFileInfo *element = [[YPFileInfo alloc] init];
        element.fileName = item;
        element.fileSize = value;
        element.fileInfo = reslut;
        element.fileImageName = imageName;
        element.filePath = [NSString stringWithFormat:@"%@/%@",self.filePath,item];
        [self.dataList addObject:element];
    }
    [self.collectionView reloadData];
}

- (void)setupSubviews {
    [self.collectionView registerClass:[YPFileBrowserElementCell class] forCellWithReuseIdentifier:@"YPFileBrowserElementCell"];
    [self.collectionView registerClass:[YPFileBrowserElementThumbnailCell class] forCellWithReuseIdentifier:@"YPFileBrowserElementThumbnailCell"];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect boudns = self.view.bounds;
    CGRect f1 = boudns;
    self.collectionView.frame = f1;
    if (self.style == YPFileBrowserStyleList) {
        CGFloat space = 0.f;/// 间隙
        CGSize itemSize = CGSizeZero;
        itemSize.width = self.collectionView.frame.size.width;
        itemSize.height = 44.f;
        self.flowLayout.itemSize = itemSize;
        self.flowLayout.minimumInteritemSpacing = 0.f;
        self.flowLayout.minimumLineSpacing = 0.f;
        self.flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    } else if(self.style == YPFileBrowserStyleThumbnail) {
        CGFloat space = 10.f;/// 间隙
        NSInteger count = 4;/// 一行显示个数
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setters | getters

- (void)setStyle:(YPFileBrowserStyle)style {
    [[NSUserDefaults standardUserDefaults] setInteger:style forKey:kNotificationFileBrowserViewModeChange];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFileBrowserViewModeChange object:nil];
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0.f;
        _flowLayout.minimumInteritemSpacing = 0.f;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (YPFileBrowserStyle)style {
    YPFileBrowserStyle style = [[NSUserDefaults standardUserDefaults] integerForKey:kNotificationFileBrowserViewModeChange];
    return style;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.style == YPFileBrowserStyleList) {
        YPFileInfo *cellModel = self.dataList[indexPath.row];
        YPFileBrowserElementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPFileBrowserElementCell" forIndexPath:indexPath];
        cell.cellModel = cellModel;
        return cell;
    } else if (self.style == YPFileBrowserStyleThumbnail) {
        YPFileInfo *cellModel = self.dataList[indexPath.row];
        YPFileBrowserElementThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPFileBrowserElementThumbnailCell" forIndexPath:indexPath];
        cell.cellModel = cellModel;
        return cell;
    } else {
        return [[UICollectionViewCell alloc] init];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    YPFileInfo *cellModel = self.dataList[indexPath.row];
    BOOL isDir;
    [manager fileExistsAtPath:cellModel.filePath isDirectory:&isDir];
    if (isDir) {
        /// 是文件夹
        YPFileBrowser *vc = [[YPFileBrowser alloc] initWithPath:cellModel.filePath];
        vc.isRoot = NO;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        /// 是文件
        YPBaseQLPreviewController *quickLookVC = [[YPBaseQLPreviewController alloc] init];
        quickLookVC.delegate = self;
        quickLookVC.dataSource = self;
        quickLookVC.currentPreviewItemIndex = indexPath.row;
        [self presentViewController:quickLookVC animated:YES completion:nil];
    }
}

#pragma mark - QLPreviewControllerDelegate, QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
   return self.dataList.count;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    YPFileInfo *cellModel = self.dataList[index];
    NSURL *url = [NSURL fileURLWithPath:cellModel.filePath];
    return url;
}

@end
