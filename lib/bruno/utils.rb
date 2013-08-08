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
  end
end