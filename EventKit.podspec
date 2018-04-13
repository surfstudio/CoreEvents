Pod::Spec.new do |s|

  s.name         = "EventKit"
  s.version      = "1.0.0"
  s.summary      = "A short description of EventKit."

  s.description  = <<-DESC
  This kit contains object that represents Events (like C# event). 
  This may simplify things like: pub/sub, delegation and other.
                   DESC

  s.homepage     = "https://github.com/LastSprint/EventKit"

  s.license      = { :type => "MIT" }

  s.author             = { "Alexander Kravchenkov" => "sprintend@gmail.com" }

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/LastSprint/EventKit.git", :tag => "#{s.version}" }

  s.source_files  = 'EventKit/EventKit/Sources/**/*.swift'

end
