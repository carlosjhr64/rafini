Gem::Specification.new do |s|

  s.name     = 'rafini'
  s.version  = '3.2.221213'

  s.homepage = 'https://github.com/carlosjhr64/rafini'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2022-12-13'
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
lib/rafini/requires.rb
lib/rafini/string.rb
  )

  s.requirements << 'ruby: ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [aarch64-linux]'

end
