module Rafini
  VERSION = '3.3.230212'
  # Constants
  autoload :Empty,     'rafini/empty'
  # Pure
  autoload :Array,     'rafini/array'
  autoload :Hash,      'rafini/hash'
  autoload :Integer,   'rafini/integer'
  autoload :String,    'rafini/string'
  # Hybrid
  autoload :Exception, 'rafini/exception'
  # Mix
  autoload :Odometers, 'rafini/odometers'
  autoload :Requires,  'rafini/requires'
end
# Requires:
#`ruby`
