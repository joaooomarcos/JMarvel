# Podfile

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def developmentTools
  pod 'SwiftLint'
end

def thirParties
  pod 'Kingfisher'
  pod 'RealmSwift'
end

def testTools
  pod 'Quick'
  pod 'Nimble'
end

target 'JMarvel' do
  
  developmentTools
  thirParties
  
  target 'JMarvelTests' do
    inherit! :search_paths
    testTools
  end
  
end

target 'JMarvelWidget' do
  developmentTools
  thirParties
end
