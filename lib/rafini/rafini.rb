module Rafini
  module Refine
    refine ::Integer do
      [Integer, String, Hash].each{|mod| using mod}
      def sec2time
        s = self.odometer(60,60,24,7,4,13)

        string = nil
        if s[0] > 0
          string = "#{s[0]} year#{(s[0]>1)? 's' : ''}"
          string << ", #{s[1]} month#{(s[1]>1)? 's' : ''}" if s[1]>0
        elsif s[1] > 0
          string = "#{s[1]} month#{(s[1]>1)? 's' : ''}"
          string << ", #{s[2]} week#{(s[2]>1)? 's' : ''}" if s[2]>0
        elsif s[2] > 0
          string = "#{s[2]} week#{(s[2]>1)? 's' : ''}"
          string << ", #{s[3]} day#{(s[3]>1)? 's' : ''}" if s[3]>0
        elsif s[3] > 0
          string = "#{s[3]} day#{(s[3]>1)? 's' : ''}"
          string << ", #{s[4]} hour#{(s[4]>1)? 's' : ''}" if s[4]>0
        else
          sec = s[6].to_s.rjust(2,'0')
          min = s[5].to_s.rjust(2,'0')
          hrs = s[4].to_s.rjust(2,'0')
          string = [hrs,min,sec].join(':')
        end

        return {
          years:   s[0],
          months:  s[1],
          weeks:   s[2],
          days:    s[3],
          hours:   s[4],
          minutes: s[5],
          seconds: s[6],
          to_s:  string,
        }.to_struct
      end

      def scale(type=:short)
        n,s = 1000, nil
        n2 = n*n

        case type
        when :short
          s = self.odometer(n,n,n,n,n)
        when :long
          s = self.odometer(n,n,n2,n2,n2)
        else
          raise "Don't know type #{type}."
        end

        string = '0'
        r = proc {|v,d,m| (v/d.to_f).round((m<10)? 2 : (m<100)? 1 : 0) }
        0.upto(5) do |i|
          if s[i] > 0
            m = s[i]
            if type==:short or i>3
              if m<n and i<5
                m += r.call(s[i+1], n, m)
              end
            else
              if m>n
                m = m.scale(:short)
              else
                d = (i==3)? n : n2
                m += r.call(s[i+1], d, m)
              end
            end
            string = m.to_s
            string << 'QTBMk'[i] if i<5
            break
          end
        end

        return {
          quadrillion: s[0],
          trillion:    s[1],
          billion:     s[2],
          million:     s[3],
          thousand:    s[4],
          ones:        s[5],
          type:        type,
          to_s:      string,
        }.to_struct
      end
    end
  end
end
