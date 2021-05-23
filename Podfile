platform :ios, '11.0'

def shared_pods
  pod 'Alamofire', '~> 5.0.0-beta.2'
  pod 'AlamofireObjectMapper'
  pod 'SwiftyJSON'
  
  pod 'Bond'
  pod 'ReactiveKit'
  
  pod "SnapKit"
  pod 'Kingfisher'
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'hepsiexpress' do
  use_frameworks!
  shared_pods
end
  
target 'hepsiexpressTests' do
  inherit! :search_paths
  use_frameworks!
  shared_pods
  testing_pods
end
