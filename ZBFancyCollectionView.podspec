Pod::Spec.new do |s|
  s.name = "ZBFancyCollectionView"
  s.version = "0.3.4"
  s.summary = "A delightful iOS ZBFancyCollectionView framework."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"373379320@qq.com"=>"373379320@qq.com"}
  s.homepage = "https://github.com/k373379320/ZBFancyCollectionView"
  s.frameworks = ["UIKit", "CoreFoundation"]
  s.source = { :git => 'https://github.com/k373379320/ZBFancyCollectionView.git', :tag => s.version.to_s }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/ZBFancyCollectionView.framework'
  s.ios.preserve_paths       = 'ios/ZBFancyCollectionView.framework'
  s.ios.public_header_files  = 'ios/ZBFancyCollectionView.framework/Versions/A/Headers/*.h' 
  s.ios.source_files         = 'ios/ZBFancyCollectionView.framework/Versions/A/Headers/*.h'
end
