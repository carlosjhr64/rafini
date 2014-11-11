module Rafini
  module Integer
    refine ::Integer do

      # odometer
      # Kinda hard to explain...
      #   123.odometer(10,10,10) #=> [3,2,1]
      #   30.odometer(2,3,5) #=> [0,0,0,1]
      #   ((60*60*24)*3 + (60*60)*12 + 60*15 + 30).odometer(60,60,24) #=> [30, 15, 12, 3]
      # Useful for making clocks, number scales, mayan long count... etc.
      def odometer(*p)
        n = self
        m = p.inject(1,:*)
        r = []

        (p.length-1).downto(0) do |i|
          y = n/m; r.unshift y
          n = n%m
          f = p[i]; m = m/f
        end
        r.unshift n

        return r
      end
    end
  end
end
