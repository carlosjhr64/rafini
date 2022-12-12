module Rafini
  module Array
    refine ::Array do
      # classify:
      # Like Set#classify
      def classify(hash: ::Hash.new{|h,k|h[k]=[]}, &block)
        block ||= lambda{|v|v.class}
        self.each{|v| hash[block[v]] << v}
        return hash
      end

      # is:
      # [:a,:b,:c].is(true) #=> {:a=>true,:b=>true,:c=>true}
      #
      # Updates a hash with the keys given by the array to the given value.
      def is(value, hash={})
        each{|key| hash[key]=value}
        return hash
      end

      # joins:
      # type _AToS = ::Array[(_AToS|_ToS)]
      # _AToS#joins(*_AToS seps)?{(_ToS,_ToS)->_ToS}
      #
      # Returns a string created by joining the elements of the (flatten) array,
      # separated by the given (flatten) separators.
      # If no separators are given or are used up,
      # it uses the value of the executed block,
      # which is passed the next neigboring iteration items.
      # Else, it just joins the items.
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
          if sep = seps.shift&.to_s || block&.call(previous,item)&.to_s
            string << sep
          end
          string << item.to_s
          previous = item
        end
        return string
      end
    end
  end
end
