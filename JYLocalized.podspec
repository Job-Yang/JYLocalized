Pod::Spec.new do |s|
  s.name         = 'JYLocalized'
  s.summary      = 'Router framework is based on runtime to push/present/pop/dismiss for iOS'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Job-Yang" => "578093143@qq.com" }
  s.homepage     = 'https://github.com/Job-Yang/JYLocalized'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/Job-Yang/JYLocalized.git', :tag => s.version}
  
  s.requires_arc = true
  s.source_files = 'JYLocalized/**/*.{h,m}'
  
end