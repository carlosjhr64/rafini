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
          sec = s[6].to_s.pad(2,'0')
          min = s[5].to_s.pad(2,'0')
          hrs = s[4].to_s.pad(2,'0')
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
        n,s = 1000, nil; n2 = n*n
        r = (type==:short)? 1 : 3
        case type
        when :short
          s = self.odometer(n,n,n,n,n)
        when :long
          s = self.odometer(n,n,n2,n2,n2)
        else
          raise "Don't know type #{type}."
        end
        string = s[5].to_s
        0.upto(4) do |i|
          if s[i] > 0
            m = s[i]
            d = (type==:short or i==4)? n : n2
            if m < d
              m += (s[i+1]/d.to_f).round(r)
            end
            string = m.to_s
            string << 'QTBMK'[i]
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
