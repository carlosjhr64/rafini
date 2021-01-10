module Rafini
  module Hash
    refine ::Hash do
      # struct = hash.to_struct
      # Why not?
      def to_struct
        Struct.new(*keys).new(*values)
      end

      # hash0.supplement!(hash1,...) #=> hash
      #
      # Supplements hash with hashes.
      # Adds missing elements only.
      #   {a:'A',b:'B'}.supplement({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'B',c:'C',d:'D'}
      def supplement!(*hashes)
        hashes.each do |hash|
          hash.each do |key, value|
            self[key] = value unless self.has_key?(key)
          end
        end
        self
      end
      def supplement(...)
        self.dup.supplement!(...)
      end

      # hash0.amend(hash1,...)
      #
      # Ammends hash with hashes.
      # Overwrites existing keys only with first key value found in amending hashes.
      #   {a:'A',b:'B'}.amend({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'X'}
      def amend!(*hashes)
        self.each_key do |key|
          value=hashes.find{_1.has_key? key}&.fetch(key) and self[key]=value
        end
        self
      end
      def amend(...)
        self.dup.amend!(...)
      end
    end
  end
end
