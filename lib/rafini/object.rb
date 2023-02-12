module Rafini
  module Object
    refine ::Object do
      def as
        yield self
      end
    end
  end
end
