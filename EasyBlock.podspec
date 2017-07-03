
Pod::Spec.new do |s|

  s.name         = "EasyBlock"
  s.version      = "0.1.3"
  s.summary      = "a easy function for Block"

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
 
  s.description  = "简单好用的支持各种事件转为闭包处理的工具,开始使用吧！"

  s.homepage     = "https://github.com/JungHsu/EasyBlock"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author  = { "JungHsu" => "1021057927@qq.com" }

  s.source       = { :git => "https://github.com/JungHsu/EasyBlock.git", :tag => "#{s.version}" }
  s.source_files  = "EasyBlockDemo/EasyBlock/**/*.{h,m}"
  s.requires_arc = true

end