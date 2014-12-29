module Rafini
  module Hash
    refine ::Hash do

      # struct = hash.to_struct
      # Why not?
      def to_struct
        Struct.new(*self.keys).new(*self.values)
      end

      # hash0.modify(hash1,...) #=> hash
      #
      # Updates hash with hashes.
      # Overwrites existing elements and adds elements.
      #    {a:'A',b:'B'}.modify({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'X',c:'Y',d:'D'}
      def modify(*hashes)
        hashes.each do |hash|
          hash.each do |key, value|
            self[key] = value
          end
        end
        self
      end

      # hash0.supplement(hash1,...) #=> hash
      #
      # Supplements hash with hashes.
      # Adds missing elements only.
      #   {a:'A',b:'B'}.supplement({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'B',c:'C',d:'D'}
      def supplement(*hashes)
        hashes.each do |hash|
          hash.each do |key, value|
            self[key] = value unless self.has_key?(key)
          end
        end
        self
      end

      # hash0.ammend(hash1,...)
      #
      # Ammends hash with hashes.
      # Overwrites existing elements only.
      #   {a:'A',b:'B'}.supplement({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'X'}
      def amend(*hashes)
        self.keys.each do |key|
          hashes.each do |hash|
            if hash.has_key?(key)
              self[key] = hash[key]
              break
            end
          end
        end
        self
      end

      # hash.maps(key1,...)
      #
      # Maps parameters list with hash.
      #    {a:'A",b:'B',c:'C'}.maps(:c,:a,:b) #=> ['C','A','B']
      def maps(*keys)
        keys.map{|_|self[_]}
      end
    end
  end
end
