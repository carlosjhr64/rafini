Gem::Specification.new do |s|

  s.name     = 'rafini'
  s.version  = '1.1.0'

  s.homepage = 'https://github.com/carlosjhr64/rafini'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2014-12-28'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Just a collection of useful refinements.
DESCRIPTION

  s.summary = <<SUMMARY
Just a collection of useful refinements.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ["--main", "README.rdoc"]

  s.require_paths = ["lib"]
  s.files = %w(
README.rdoc
lib/rafini.rb
lib/rafini/array.rb
lib/rafini/empty.rb
lib/rafini/exception.rb
lib/rafini/hash.rb
lib/rafini/integer.rb
lib/rafini/odometers.rb
lib/rafini/string.rb
lib/rafini/version.rb
  )

  s.requirements << 'ruby: ruby 2.1.3p242 (2014-09-19 revision 47630) [x86_64-linux]'

end
