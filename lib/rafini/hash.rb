module Rafini
  module Hash
    refine ::Hash do
      def to_struct
        Struct.new(*self.keys).new(*self.values)
      end
    end
  end
end
