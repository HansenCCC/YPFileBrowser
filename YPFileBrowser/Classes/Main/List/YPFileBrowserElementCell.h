//
//  YPFileBrowserElementCell.h
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/7.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPFileInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPFileBrowserElementCell : UICollectionViewCell

@property (nonatomic, strong) YPFileInfo *cellModel;
@property (nonatomic, assign) BOOL isDisplayRightImage;/// default YES

@end

@interface YPFileBrowserElementThumbnailCell : UICollectionViewCell

@property (nonatomic, strong) YPFileInfo *cellModel;

@end

NS_ASSUME_NONNULL_END
