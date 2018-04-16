Pod::Spec.new do |s|

  s.name         = "EventsKit"
  s.version      = "1.0.0"
  s.summary      = "Small library contains rx-like events."

  s.description  = <<-DESC
  This library contains object represents Events (like C# event). 
  This may simplify things like: pub/sub, delegation, notification and other.
                   DESC

  s.homepage     = "https://github.com/LastSprint/EventsKit"

  s.license      = { :type => "MIT" }

  s.author             = { "Alexander Kravchenkov" => "sprintend@gmail.com" }

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/LastSprint/EventsKit.git", :tag => "#{s.version}" }

  s.source_files  = 'EventsKit/EventsKit/Sources/**/*.swift'

end
