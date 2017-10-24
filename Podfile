platform :ios, '11.0'

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def all_pods

pod 'AlamofireImage'

end

post_install do |installer|
  require 'fileutils'

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_TESTABILITY'] = 'NO'
      config.build_settings['ALWAYS_SEARCH_USER_PATHS'] = 'NO'
    end
  end
end
