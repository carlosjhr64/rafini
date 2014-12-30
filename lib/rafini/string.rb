module Rafini
  module String
    refine ::String do
      # camelize:
      # 1) A camel kick, as in "I gotz camelized".
      # 2) "a_camel_kick" => "ACamelKick"
      def camelize(sep=/_/)
        self.split(sep).map{|word|word.capitalize }.join('')
      end

      # semantic:
      # 'a.b.c'.semantic(1) #=> 'b'
      # 'a.b.c'.semantic(0..1) #=> 'a.b'
      # 'a.b.c'.semantic(0..2, '/') #=> 'b/c'
      # 'a/b/c'.semantic(0..2, '.', /\//) #=> 'a.b.c'
      def semantic(v,s='.',sx=/\./)
        [*self.split(sx)[v]].join(s)
      end
    end
  end
end
