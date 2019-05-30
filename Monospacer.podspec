Pod::Spec.new do |s|
  s.name         = "Monospacer"
  s.version      = "0.5.0"
  s.summary      = "A small framework to generate monospaced fonts."

  s.description  = <<-DESC
A framework for macOS, iOS, tvOS, and watchOS to create monospaced variants of
fonts.
                   DESC

  s.license      = "MIT"

  s.author             = { "Jeff Kelley" => "SlaunchaMan@gmail.com" }
  s.social_media_url   = "https://twitter.com/SlaunchaMan"
  s.homepage           = "https://github.com/SlaunchaMan/Monospacer"

  s.module_name = "Monospacer"
  s.swift_versions = ['4.0', '4.1', '4.2', '5.0']

  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/SlaunchaMan/Monospacer.git",
                     :tag => "#{s.version}" }

  s.source_files  = "Code/*.swift"

  s.osx.framework = "AppKit"
  s.ios.framework = "UIKit"
  s.watchos.framework = "UIKit"
  s.tvos.framework = "UIKit"
end
