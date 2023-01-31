Pod::Spec.new do |s|
  s.name             = 'TuIdentidadSDK'
  s.version          = '1.1.7'
  s.summary          = 'Official Tu Identidad SDK for iOS to access Tu Identidad Platform'

  s.description      = <<-DESC
Used to integrate the Tu Identidad Platform with your iOS apps.
Validation Services:
- INE
                       DESC

  s.homepage         = 'https://github.com/tu-identidad/tu-identidad-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aaron Munguia' => 'aaron.munguia@tuidentidad.com' }
  s.source           = { :git => 'https://github.com/tu-identidad/tu-identidad-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.platform = :ios, '10.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.source_files = 'TuIdentidadSDK/Classes/**/*'
  
  s.resource_bundles = {
    'TuIdentidadSDK' => [
      'TuIdentidadSDK/Assets/*.{png,xib,xcassets,strings}',
      'TuIdentidadSDK/Assets/**/**/*'
    ]
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Alamofire'
#  s.dependency 'Eureka', '~> 5.1.0'
  s.dependency 'HandyJSON', '~> 5.0.1'
  s.dependency 'JGProgressHUD'
  s.dependency 'MBDocCapture'
  s.dependency 'Toast-Swift', '~> 5.0.0'
  
  s.default_subspecs = 'CoreKit'
  
  s.subspec 'CoreKit' do |ss|
    ss.source_files = 'CoreKit/**/*'
  end
  
  s.subspec 'AddressKit' do |ss|
    ss.dependency 'TuIdentidadSDK/CoreKit'
    ss.source_files = 'AddressKit/**/*'
  end
end
