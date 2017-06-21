#
# Be sure to run `pod lib lint JoyTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JoyTool'
  s.version          = '0.0.8'
  s.summary          = 'add animation\layer ex...'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/joy-make/JoyTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'joy-make' => '315585646@qq.com' }
  s.source           = { :git => 'https://github.com/joy-make/JoyTool.git', :tag => s.version.to_s }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.default_subspec = 'Common'


  s.subspec 'Category' do |ss|
  ss.source_files = 'JoyTool/Category/**/*.{h,m}'
  end

  s.subspec 'CellsLibruary' do |ss|
  ss.source_files = 'JoyTool/CellsLibruary/**/*.{h,m,xib}'
  end

s.subspec 'Common' do |ss|
ss.source_files = 'JoyTool/Common/**/*.{h}'
end

s.subspec 'Controllers' do |ss|
ss.source_files = 'JoyTool/Controllers/**/*.{h,m}'
end

s.subspec 'Interactor' do |ss|
ss.source_files = 'JoyTool/Interactor/**/*.{h,m}'
end

s.subspec 'Models' do |ss|
ss.source_files = 'JoyTool/Models/**/*.{h,m}'
end

s.subspec 'Presenter' do |ss|
ss.source_files = 'JoyTool/Presenter/**/*.{h,m}'
end

s.subspec 'Protocols' do |ss|
ss.source_files = 'JoyTool/Protocols/**/*.{h}'
end

s.subspec 'Utility' do |ss|
ss.source_files = 'JoyTool/Utility/**/*.{h}'
end

s.subspec 'Views' do |ss|
ss.source_files = 'JoyTool/Views/**/*.{h,m,xib}'
end

s.resource_bundles = {
'JoyTool' => ['JoyTool/**/*.{png,jpg,jpeg,plist}']
}


  # s.source_files = 'JoyTool/**/*.{h,m}'

  # s.resource_bundles = {
  #   'JoyTool' => ['JoyTool/**/*.{xib,png,jpg,jpeg,plist}']
  #  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Masonry'

end
