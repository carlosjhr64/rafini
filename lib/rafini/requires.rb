module Rafini
  module Requires
    refine ::String do
      # satisfies?:
      # "1.2.3".satisfies?('~>1.1') #=> true
      # "1.2.3".satisfies?('~>2.3') #=> false
      def satisfies?(*reqs)
        Gem::Requirement.new(*reqs).satisfied_by? Gem::Version.new(self)
      end
    end

    refine ::Kernel do
      def requires(*list)
        loaded = []
        list.each do |gems|
          gems.lines.each do |gemname_reqs|
            gemname, *reqs = gemname_reqs.split
            next unless gemname
            unless reqs.empty?
              case gemname
              when 'rafini'
                unless VERSION.satisfies?(*reqs)
                  raise "helpema #{VERSION} not #{reqs.join(', ')}"
                end
                next
              when 'ruby'
                unless RUBY_VERSION.satisfies?(*reqs)
                  raise "ruby #{RUBY_VERSION} not #{reqs.join(', ')}"
                end
                next
              else
                gem gemname, *reqs
              end
            end
            require gemname and loaded.push gemname
          end
        end
        loaded
      end
    end
  end

  using Requires
  def self.requires(*list) = Kernel.requires(*list)
end
