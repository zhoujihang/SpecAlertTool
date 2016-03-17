Pod::Spec.new do |s|

  s.name         = "AlertTool"
  s.version      = "0.0.1"
  s.summary      = "quick alert and toast"

  s.description  = <<-DESC
            one line code show alert or toast
                   DESC

  s.homepage     = "https://github.com/zhoujihang/SpecAlertTool.git"
  s.license      = "MIT"
  s.author             = { "zhoujihang" => "zhoujihang@ayibang.com" }
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/zhoujihang/SpecAlertTool.git", :tag => s.version }

  s.source_files  = "AlertTool/**/*.{h,m}"

  s.dependency 'Masonry', '~> 0.6.4'

end
