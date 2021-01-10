Gem::Specification.new do |s|

  s.name     = 'rafini'
  s.version  = '3.0.210110'

  s.homepage = 'https://github.com/carlosjhr64/rafini'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-01-10'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Just a collection of useful refinements.
DESCRIPTION

  s.summary = <<SUMMARY
Just a collection of useful refinements.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/rafini.rb
lib/rafini/array.rb
lib/rafini/empty.rb
lib/rafini/exception.rb
lib/rafini/hash.rb
lib/rafini/integer.rb
lib/rafini/odometers.rb
lib/rafini/string.rb
  )

  s.requirements << 'ruby: ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]'

end
