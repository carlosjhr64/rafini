module Rafini
  module String
    refine ::String do
      def name_split
        split(/[ _-]|(?=[A-Z])/)
      end
      # MyNameIsRuby
      def pascal_case
        name_split.map(&:capitalize).join
      end
      alias_method :title_case, :pascal_case
      # myNameIsRuby
      def camel_case
        pascal_case.tap{_1[0]=_1[0].downcase}
      end
      # my_name_is_ruby
      def snake_case(sep='_')
        name_split.map(&:downcase).join(sep)
      end
      # my-name-is-ruby
      def kebab_case
        snake_case('-')
      end

      # camelize:
      # 1) A camel kick, as in "I gotz camelized".
      # 2) "a_camel_kick" => "ACamelKick"
      def camelize(sep='_')
        split(sep).map(&:capitalize).join
      end

      # semantic:
      # 'a.b.c'.semantic(1) #=> 'b'
      # 'a.b.c'.semantic(0..1) #=> 'a.b'
      # 'a.b.c'.semantic(0..2, join:'/') #=> 'b/c'
      # 'a/b/c'.semantic(0..2, split:'/', join:'.') #=> 'a.b.c'
      def semantic(v=(0..2), split:'.', join:'.')
        [*split(split)[v]].join(join)
      end

      # shellescape:
      # Same funtionality as Shellword's String#shellescape
      def shellescape
        # This is a contraction of Shellwords.escape function
        gsub(/[^\w\-.,:+\/@\n]/,'\\\\\\&').gsub(/\n/,"'\n'")
      end
    end
  end
end
