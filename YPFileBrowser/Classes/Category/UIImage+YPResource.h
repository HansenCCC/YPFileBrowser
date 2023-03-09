//
//  UIImage+YPFileBrowser.h
//  KKFileBrowser
//
//  Created by shinemo on 2021/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YPResource)

/// 根据文件名字获取 Bundle 图片
/// - Parameter name: imageName
+ (UIImage *)yp_imageWithBundleImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
