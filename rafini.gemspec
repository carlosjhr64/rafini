Gem::Specification.new do |s|
  ## INFO ##
  s.name     = 'rafini'
  s.version  = '3.3.230212'
  s.homepage = 'https://github.com/carlosjhr64/rafini'
  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'
  s.date     = '2023-02-12'
  s.licenses = ['MIT']
  ## DESCRIPTION ##
  s.summary  = <<~SUMMARY
    Just a collection of useful refinements.
  SUMMARY
  s.description = <<~DESCRIPTION
    Just a collection of useful refinements.
  DESCRIPTION
  ## FILES ##
  s.require_paths = ['lib']
  s.files = %w[
    README.md
    lib/rafini.rb
    lib/rafini/array.rb
    lib/rafini/empty.rb
    lib/rafini/exception.rb
    lib/rafini/hash.rb
    lib/rafini/integer.rb
    lib/rafini/object.rb
    lib/rafini/odometers.rb
    lib/rafini/requires.rb
    lib/rafini/string.rb
  ]
  
  ## REQUIREMENTS ##
  s.add_runtime_dependency 'help_parser', '~> 8.2', '>= 8.2.230210'
  s.add_development_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  s.add_development_dependency 'cucumber', '~> 8.0', '>= 8.0.0'
  s.add_development_dependency 'parser', '~> 3.2', '>= 3.2.1'
  s.add_development_dependency 'rubocop', '~> 1.45', '>= 1.45.1'
  s.add_development_dependency 'stringio', '~> 3.0', '>= 3.0.5'
  s.add_development_dependency 'test-unit', '~> 3.5', '>= 3.5.7'
  s.requirements << 'git: 2.30'
  s.requirements << 'ruby: 3.2'
end
