module Rafini
  module Array
    refine ::Array do
      def joins(*p, &block)
        s, j, l = '', p.length, length
        if l > 0
          s << self[0].to_s
          1.upto(l-1) do |i|
            s << ((i > j)? ((block)? block.call(i) : '' ) : p[i-1]).to_s
            s << self[i].to_s
          end
        end
        return s
      end

      def per(b=nil)
        0.upto(length-1){|i| yield self[i], (b)? b[i] : i}
      end
    end
  end
end
