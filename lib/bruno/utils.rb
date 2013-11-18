module Bruno
  module Utils
    def self.distance(n1, n2)
      if n1.respond_to?(:lat) && n1.respond_to?(:lon)
        lat1, lon1 = n1.lat, n1.lon
        lat2, lon2 = n2.lat, n2.lon
      elsif n1.kind_of? Hash
        lat1, lon1 = n1[:lat], n1[:lon]
        lat2, lon2 = n2[:lat], n2[:lon]
      else
        raise "Nodes doesn't have lat and lon values"
      end
      
      dlat  = lat2 - lat1
      dlon  = lon2 - lon1

      Math.sqrt dlat**2 + dlon**2
    end

    def self.levenshtein_distance(_self, other, ins=2, del=2, sub=1)
      return nil if _self.nil?
      return nil if other.nil?
      dm = []
      dm[0] = (0.._self.length).collect { |i| i * ins }
      fill = [0] * (_self.length - 1)
      for i in 1..other.length
        dm[i] = [i * del, fill.flatten]
      end

      for i in 1..other.length
        for j in 1.._self.length
          dm[i][j] = [
               dm[i-1][j-1] +
                 (_self[j-1] == other[i-1] ? 0 : sub),
                   dm[i][j-1] + ins,
               dm[i-1][j] + del
         ].min
        end
      end

      dm[other.length][_self.length]
    end

  end
end