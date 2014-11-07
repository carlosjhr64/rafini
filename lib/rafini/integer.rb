module Rafini
  module Integer
    refine ::Integer do
      def odometer(*p)
        n = self
        m = p.inject(1,:*)
        raise "Busted the odometer" if n>m
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
