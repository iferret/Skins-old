#
#  Be sure to run `pod spec lint Skins.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "Skins"
  spec.version      = "0.0.2"
  spec.summary      = "Theme of UIKit"
  spec.homepage     = "https://github.com/imotoboy/Skins"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "tramp" => "wanggang3@staff.sina.com.cn" }
  
  spec.swift_version = "5.0"

  spec.ios.deployment_target = "11.0"
  spec.ios.frameworks = 'SafariServices'

  spec.source       = { :git => "https://github.com/imotoboy/Skins.git", :tag => "#{spec.version}" }

  spec.source_files  = ["Skins/Source/**/*.swift", "Skins/*.swift"]

  # 解决在xcode 12下验证不通过的问题
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
