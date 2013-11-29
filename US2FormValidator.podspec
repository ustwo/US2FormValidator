Pod::Spec.new do |s|
  s.name            = 'US2FormValidator'
  s.version         = '2.0.10-beta'
  s.license         = 'MIT'
  s.summary         = 'A lightweight iOS form validation framework.'
  s.homepage        = 'https://github.com/ustwo/US2FormValidator'
  s.authors          = {'Martin Stolz' => 'martin@ustwo.co.uk', 'Alex Fish' => 'fish@ustwo.co.uk', 'Mio Nilsson' => 'mio@ustwo.co.uk'}
  s.description     = 'This framework allows you to validate inputs of text fields and text views in a convenient way. Add your own validators and dependencies of validations.'
  s.platform        = :ios
  s.source          = { :git => 'https://github.com/ustwo/US2FormValidator.git', :tag => '2.0.10-beta' }
  s.source_files    = 'US2FormValidationFramework/source/**/*.{h,m}'
  s.resources       = 'US2FormValidationFramework/US2Localizable/*'
  s.requires_arc    = true
  s.preserve_paths  = 'Documentation', 'US2FormValidationFrameworkSample', 'US2FormValidationFramework/tests', 'US2FormValidationFramework/documentation', 'US2FormValidationFramework/US2FormValidationFramework.xcodeproj'
end
