Pod::Spec.new do |s|
  s.name             = 'Model'
  s.version          = '0.1.0'
  s.summary          = 'Base classes to implement Business-model. Samples included.'
  s.description      = <<-DESC
                       Yet another approach of organizing business logic layer. Includes all base classes as well as Sample project to dive deep into this approach.
                       DESC

  s.homepage         = 'https://github.com/zSOLz/model'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Solovey' => 'sol.bsuir@gmail.com' }
  s.source           = { :git => 'https://github.com/zSOLz/model.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'Model/Model/**/*.swift'
  s.requires_arc = true
  s.frameworks = 'Foundation'
end
