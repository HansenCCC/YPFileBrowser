#
# Be sure to run `pod lib lint YPFileBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YPFileBrowser'
  s.version          = '2.0.0'
  s.summary          = '一个非常实用的文件浏览工具库'
  s.description      = <<-DESC
  当开发iOS应用程序时，经常需要查看和管理应用程序中的文件。YPFileBrowser 是一个文件预览库，可以帮助开发人员快速导出和预览应用程序中的各种文件类型。该库支持多种常见的文件格式，包括音频、视频、Word文档、PPT、图像等。
                       DESC
  s.homepage         = 'https://github.com/HansenCCC/YPFileBrowser'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenghengsheng' => '2534550460@qq.com' }
  s.source           = { :git => 'https://github.com/HansenCCC/YPFileBrowser', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'YPFileBrowser/Classes/**/*'
  s.resource = 'YPFileBrowser/Assets/YPFileBrowser.bundle'
  
end
