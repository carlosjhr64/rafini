module Rafini
  # In a world where objects are allowed to represent infinities,
  # Rafini dares to introduce empty sets.  But WHY!???
  # Ta-ta-TUM...
  module Empty
    ARRAY  = [].freeze
    HASH   = {}.freeze
    STRING = ''.freeze

    def a0 = ARRAY
    def h0 = HASH
    def s0 = STRING
  end
end
