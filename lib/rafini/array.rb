module Rafini
  module Array
    refine ::Array do
      def joins(*p, &block)
        str = ''
        if length > 1
          str << self[0]
          1.upto(length-1) do |i|
            str << (p.empty? ? (block ? block.call(i).to_s : '') : p.shift.to_s)
            str << self[i]
          end
        end
        return str
      end

      def per(b=nil)
        0.upto(length-1){|i| yield self[i], (b)? b[i] : i}
      end
    end
  end
end
