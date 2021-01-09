module Rafini
  module Array
    refine ::Array do
      # type _AToS = ::Array[(_AToS|_ToS)]
      # _AToS#joins(*_AToS seps)?{(_ToS,_ToS)->_ToS}
      #
      # Returns a string created by joining the elements of the (flatten) array,
      # separated by the given (flatten) separators.
      # If no separators are given or are used up,
      # it uses the value of the executed block, which is passed the next neigboring iteration items.
      # Lastly it uses an empty string.
      #    ['2021','Jan','09','07','29','05'].joins('-', '-', ' '){':'}
      #    #=> "2021-Jan-09 07:29:05"
      #    [:a,[1,2],:b].joins{','} #=> 'a,1,2,b'
      #    [3,1,4,1,5,9].joins('.') #=> '3.14159'
      #    [1,9,2,8,3,7,4,6,5,5].joins{|a,b|a>b ? '>': a<b ? '<': '='}
      #    #=> "1<9>2<8>3<7>4<6>5=5"
      def joins(*seps, &block)
        return '' if length < 1
        items = flatten
        previous = items.shift
        string = ::String.new previous.to_s
        return string if items.empty?
        seps.flatten!
        while item = items.shift
          sep = seps.shift&.to_s || block&.call(previous,item).to_s and string << sep
          string << item.to_s
          previous = item
        end
        return string
      end

      # array1.per(array2){|obj1, obj2| ... }
      #
      # Gives the block each two elements of two array respectively.
      # If the second array is not given, it passes the block the index number instead.
      #   h={} # say you have a hash h, then
      #   ['a','b','c'].per(['A','B','C']){|l,n| h[l]=n} # h=={'a'=>'A','b'=>'B','c'=>'C'}
      #   ['a','b','c'].per{|l,i| h[l]=i} # h=={'a'=>0,'b'=>1,'c'=>2}
      def per(b=nil)
        each_with_index{|item,i| yield item, b ? b[i] : i}
      end

      # [:a,:b,:c].is(true) #=> {:a=>true,:b=>true,:c=>true}
      #
      # Updates a hash with the keys given by the array to the given value.
      def is(value, hash={})
        each{|key| hash[key]=value}
        return hash
      end
    end
  end
end
