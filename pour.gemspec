$:.push File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
require 'pour/gem'

Gem::Specification.new do |s|
  s.name              = Pour::Gem.name
  s.version           = Pour::Gem.version
  s.platform          = Gem::Platform::RUBY
  s.author            = Pour::Gem.author.name
  s.email             = Pour::Gem.author.email
  s.homepage          = Pour::Gem.homepage
  s.summary           = Pour::Gem.summary
  s.description       = Pour::Gem.description
  s.license           = Pour::Gem.license

  s.required_ruby_version = '>= 1.9.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)

  s.add_dependency 'typespec'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'aruba'
end
