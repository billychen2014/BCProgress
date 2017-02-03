Pod::Spec.new do |s|
  s.name         = "BCProgressView"
  s.version      = "0.0.1"
  s.summary      = "progress implemented via CALyer"
  s.description  =  %{
    BCProgressView support 3 types of progress, please refer to source code!
    please mail to baikthh520@yeah.net if any errors, thanks.
  }

  s.homepage     = "https://github.com/billychen2014/BCProgress"
  s.license      = "ZuoZH"
  
  s.author             = { "chenchuan" => "chenchuan@zuozh.com" }
  s.source       = { :git => "https://github.com/billychen2014/BCProgress.git", :tag => "0.0.1" }

  s.source_files  = "Classes", "BCProgressView/Class/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.platform     = :ios, '7.0'
  s.framework    = 'QuartzCore'
  s.requires_arc = true
end
