#
Pod::Spec.new do |s|
  s.name = 'ZBFancyCollectionView'
  s.version = '0.3.1'
  s.summary = 'A delightful iOS ZBFancyCollectionView framework.'
  s.homepage = 'https://github.com/k373379320/ZBFancyCollectionView'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { '373379320@qq.com' => '373379320@qq.com' }
  s.source = { :git => 'https://github.com/k373379320/ZBFancyCollectionView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ZBFancyCollectionView/Classes/**/*'
  s.prefix_header_contents = '#import "ZBFancyCollectionViewPrefixHeader.h"'
  s.frameworks = 'UIKit','CoreFoundation'
end