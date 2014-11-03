module Rafini
  module String
    refine ::String do
      # camelize:
      # 1) A camel kick, as in "I gotz camelized".
      # 2) "a_camel_kick" => "ACamelKick"
      def camelize(sep=/_/)
        self.split(sep).map{ |word| word.capitalize }.join('')
      end

      def pad(l,c=' ')
        s = self.dup
        while s.length < l
          s.prepend c
        end
        return s
      end
    end
  end
end
