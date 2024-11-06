Pod::Spec.new do |s|
  s.name                = "ZH_LLDebugTool"
  s.version             = "0.0.6"
  s.summary             = "ZH_LLDebugTool is a debugging tool for developers and testers that can help you analyze and manipulate data in non-xcode situations."
  s.homepage            = "https://github.com/ShinesZhao/ZH_LLDebugTool"
  s.license             = "MIT"
  s.author              = { "User" => "472059581@qq.com" }
  s.social_media_url    = "https://github.com/ShinesZhao"
  s.platform            = :ios, "10.0"
  s.source              = { :git => "https://github.com/ShinesZhao/ZH_LLDebugTool.git", :tag => "#{s.version}" }
  s.requires_arc        = true
  s.source_files        = "ZH_LLDebugTool/**/*.{h,m}" #文件夹分类报错
  s.resource            = "ZH_LLDebugTool/Core/Others/Resource/LLDebugTool.bundle"
  s.dependency            "FMDB"
  
end
