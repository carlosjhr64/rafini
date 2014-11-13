module Rafini
  # In a world where objects are allowed to represent infinities,
  # Rafini dares to introduce empty sets.  But WHY!???
  # Ta-ta-TUM...
  module Empty
    ARRAY = [].freeze
    HASH  = {}.freeze
  end
end
