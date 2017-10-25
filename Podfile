platform :ios, '11.0'

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def all_pods

pod 'AlamofireImage'
pod 'OBehave', git: 'https://github.com/warren-gavin/OBehave.git', :tag => '0.0.8'
pod 'APDownloader', git: 'https://github.com/warren-gavin/APDownloader.git', :tag => '0.0.1'

end

target 'PropertyFinder' do
  project 'PropertyFinder.xcodeproj'
  all_pods

  target 'PropertyFinderTests' do
    inherit! :search_paths
  end
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
