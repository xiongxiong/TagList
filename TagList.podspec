#
# Be sure to run `pod lib lint TagList.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TagList'
  s.version          = '0.2.12'
  s.summary          = 'TagList, flexible tag list view, easy to use & extend.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TagList, flexible tag list view, easy to use & extend. I love it.
                       DESC

  s.homepage         = 'https://github.com/xiongxiong/TagList'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiongxiong' => 'xiongxiong0619@gmail.com' }
  s.source           = { :git => 'https://github.com/xiongxiong/TagList.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Framework/SwiftTagList/**/*.{h,swift}'
  s.resource_bundles = {
    'Resources' => ['Framework/SwiftTagList/Assets.xcassets/**/*.png']
  }

  s.public_header_files = 'Framework/SwiftTagList/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
