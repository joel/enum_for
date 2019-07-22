lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enum_for/version'

Gem::Specification.new do |spec|
  spec.name          = 'enum_for'
  spec.version       = EnumFor::VERSION
  spec.authors       = ['Joel AZEMAR']
  spec.email         = ['joel.azemar@gmail.com']

  spec.summary       = %q{Alternative to ActiveRecord::Enum}
  spec.description   = %q{ActiveRecord::Enum fire SQL request and bypass ActiveModel::Validations, this let you play with enum and validation}
  spec.homepage      = 'https://github.com/joel/enum_for'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 5.2'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
  
  spec.add_development_dependency 'rubocop-performance', '~> 1.4'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.33'
  spec.add_development_dependency 'simplecov', '~> 0.17'
  spec.add_development_dependency 'yardstick', '~> 0.9'
  spec.add_development_dependency 'pry-byebug', '~> 3.7'
  
  spec.add_development_dependency 'sqlite3', '~> 1.4'
  spec.add_development_dependency 'with_model', '~> 2.1'
end
