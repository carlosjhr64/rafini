module Rafini
  module String
    refine ::String do
      # camelize:
      # 1) A camel kick, as in "I gotz camelized".
      # 2) "a_camel_kick" => "ACamelKick"
      def camelize(sep='_')
        self.split(sep).map(&:capitalize).join
      end

      # semantic:
      # 'a.b.c'.semantic(1) #=> 'b'
      # 'a.b.c'.semantic(0..1) #=> 'a.b'
      # 'a.b.c'.semantic(0..2, join:'/') #=> 'b/c'
      # 'a/b/c'.semantic(0..2, split:'/', join:'.') #=> 'a.b.c'
      def semantic(v=(0..2), split:'.', join:'.')
        [*self.split(split)[v]].join(join)
      end

      # shellescape:
      # Same funtionality as Shellword's String#shellescape
      def shellescape
        # This is a contraction of Shellwords.escape function
        self.gsub(/[^\w\-.,:+\/@\n]/,'\\\\\\&').gsub(/\n/,"'\n'")
      end
    end
  end
end
