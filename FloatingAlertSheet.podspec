#
# Be sure to run `pod lib lint FloatingAlertSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatingAlertSheet'
  s.version          = '0.1.0'
  s.summary          = 'Its pod library for new presenter AlertSheet of FloatingAlertSheet.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Its pod library for new presenter AlertSheet of FloatingAlertSheet. Current testing version.
                       DESC

  s.homepage         = 'https://github.com/Single-sh/FloatingAlertSheet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander' => 'shevchenko.a.i14@gmail.com' }
  s.source           = { :git => 'https://github.com/Single-sh/FloatingAlertSheet.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

#  s.resources = 'FloatingAlertSheet/**/*.{xib}'
  s.source_files = 'FloatingAlertSheet/Classes/**/*'

  # s.resource_bundles = {
  #   'FloatingAlertSheet' => ['FloatingAlertSheet/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
