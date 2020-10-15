#
# Be sure to run `pod lib lint FSJUtility.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FSJUtility'
  s.version          = '1.0.1'
  s.summary          = '这里总结了一些实用的工具，比如扩大按钮的点击区域，防止重复点击按钮，json转换，字母排序，序列化归档，AES base64 MD5，手机号正则，创建UI的快捷方式，16进制颜色转换，二维码生成，View的圆角，一些简单动画，底部弹框 弹框集合，包含ChildController的容器，方法交换，延迟操作 取消操作 等等'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/smallMas/FSJUtility'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanshij@163.com' => 'fanshij@163.com' }
  s.source           = { :git => 'https://github.com/smallMas/FSJUtility.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'FSJUtility/Classes/**/*'
  # 从podspec同级目录开始
  s.source_files = 'Libs/**/*.{m,h}'
  
  # s.resource_bundles = {
  #   'FSJUtility' => ['FSJUtility/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
