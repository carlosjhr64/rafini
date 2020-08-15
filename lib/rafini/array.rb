module Rafini
  module Array
    refine ::Array do

      # string = array.joins(sep1,sep2,sep3,...){|i| sep[i]}
      #
      # Returns a string created by converting each element of the array to
      # a string, separated by the given separators.
      # If no separators are given or are used up,
      # it uses the value of the executed block, which is passed an iteration number.
      # Note that the iteration number starts at 1.
      # Lastly it uses an empty string.
      #    ['a','b','c','d','e','f'].joins('-', '-', ' '){':'} #=> 'a-b-c d:e:f'
      #    ['a','b','c'].joins{','} #=> 'a,b,c'
      #    ['1','2','3'].joins('.') #=> '1.23'
      #    ['a','b','c'].joins{|i|i} #=> 'a1b2c'
      def joins(*p, &block)
        str = ''
        if length > 0
          str << self[0]
          1.upto(length-1) do |i|
            str << (p.empty? ? (block ? block.call(i).to_s : '') : p.shift.to_s)
            str << self[i]
          end
        end
        return str
      end

      # array1.per(array2){|obj1, obj2| ... }
      #
      # Gives the block each two elements of two array respectively.
      # If the second array is not given, it passes the block the index number instead.
      #   h={} # say you have a hash h, then
      #   ['a','b','c'].per(['A','B','C']){|l,n| h[l]=n} # h=={'a'=>'A','b'=>'B','c'=>'C'}
      #   ['a','b','c'].per{|l,i| h[l]=i} # h=={'a'=>0,'b'=>1,'c'=>2}
      def per(b=nil)
        0.upto(length-1){|i| yield self[i], (b)? b[i] : i}
      end

      # array.which{|a|...}
      #
      # Returns first object for which block is true.
      # ['dog','cat','bunny'].which{|a|a=~/c/} #=> "cat"
      alias which detect

      # [:a,:b,:c].is(true) #=> {:a=>true,:b=>true,:c=>true}
      #
      # Updates a hash with the keys given by the array to the given value.
      def is(value, hash={})
        self.each{|key| hash[key]=value}
        return hash
      end
    end
  end
end
