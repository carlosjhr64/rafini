module Rafini
  module Hash
    refine ::Hash do

      # struct = hash.to_struct
      # Why not?
      def to_struct
        Struct.new(*self.keys).new(*self.values)
      end
    end
  end
end
