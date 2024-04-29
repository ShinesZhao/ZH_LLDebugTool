#
#  Be sure to run `pod spec lint ZH_LLDebugTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "ZH_LLDebugTool"
  spec.version      = "0.0.2"
  spec.summary      = "LLDebugTool adapter"
  spec.description  = "UIBarbutton adapter"
  spec.homepage     = "https://github.com/ShinesZhao/ZH_LLDebugTool"
  spec.license      = "MIT"
  spec.author       = { "User" => "472059581@qq.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/ShinesZhao/ZH_LLDebugTool.git", :tag => "#{spec.version}" }
  #spec.source_files  = "ZH_LLDebugTool/*.{h,m,swift}","ZH_LLDebugTool/Core/**/*.{h,m,swift}","ZH_LLDebugTool/DebugTool/*.{h,m,swift}"
   spec.source_files  = "ZH_LLDebugTool/**/*.{h,m}"
  
  spec.requires_arc = true
  spec.dependency "FMDB"

end
