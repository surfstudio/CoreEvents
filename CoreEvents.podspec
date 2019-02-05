Pod::Spec.new do |s|

  s.name         = "CoreEvents"
  s.version      = "1.3.0"
  s.summary      = "Small library contains rx-like events."

  s.description  = <<-DESC
  This library contains object represents Events (like C# event).
  This may simplify things like: pub/sub, delegation, notification and other.
                   DESC

  s.homepage     = "https://github.com/surfstudio/CoreEvents"

  s.license      = { :type => "MIT" }

  s.author             = { "Alexander Kravchenkov" => "a.a.kravchenkov@gmail.com" }

  s.ios.deployment_target = "9.0"

  s.osx.deployment_target = "10.9"

  s.source       = { :git => "https://github.com/surfstudio/CoreEvents.git", :tag => "#{s.version}" }

  s.source_files  = 'CoreEvents/CoreEvents/Sources/**/*.swift'

end
