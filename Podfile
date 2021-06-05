# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target '8cres' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'Firebase'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'
  pod 'Plaid', '1.1.34'
  pod 'Moya'
  
  plugin 'cocoapods-keys', {
    :project => "8cres",
    :target => "8cres",
    :keys => [
      "clientID",
      "secret_sandbox",
      "secret_development"
    ]
  }
  
  target '8cresTests' do
      inherit! :search_paths
      # Pods for testing
    end

end
