Pod::Spec.new do |spec|
  
  spec.name        = "SwiftEventCenter"
  spec.version     = "1.0.0"
  spec.summary     = "Swift Event Center to create custom events and respond to them"
  spec.homepage    = "https://github.com/ladislas/SwiftEventCenter"
  spec.license     = { :type => "Apache License, Version 2.0" }
  spec.author     = "Ladislas de Toldi"
  spec.module_name  = 'EventCenter'

  spec.swift_version = "4.2"
  spec.osx.deployment_target = "10.13"
  spec.ios.deployment_target = "10.0"
  spec.tvos.deployment_target = "10.0"
  spec.source   = { :git => "https://github.com/ladislas/SwiftEventCenter.git", :tag => spec.version }
  spec.source_files = "Sources/*.swift"
  spec.pod_target_xcconfig =  {
        'SWIFT_VERSION' => '4.2',
  }
  spec.framework = "Foundation"

end
