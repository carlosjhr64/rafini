module Rafini
  module Integer
    refine ::Integer do
      def odometer(*p)
        n = self
        m = p.inject(1,:*)
        r = []

        (p.length-1).downto(0) do |i|
          y = n/m; r.push y
          n = n%m
          f = p[i]; m = m/f
        end
        r.push n

        return r
      end
    end
  end
end
