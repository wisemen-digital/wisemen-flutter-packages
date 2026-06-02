#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint wisewidgetslibrary.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'wisewidgetslibrary'
  s.version          = '2.0.0'
  s.summary          = 'custom made widgets'
  s.description      = <<-DESC
  Library for all self made widgets.
                       DESC
  s.homepage         = 'https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wisewidgetslibrary'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Circle Flutter' => 'circle-flutter@appwise.be' }
  s.source           = { :path => '.' }
  s.source_files = 'wisewidgetslibrary/Sources/wisewidgetslibrary/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
