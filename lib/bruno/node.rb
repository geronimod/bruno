module Bruno
  class Node
    attr_reader :id, :tags, :lat, :lon, :karlsruhe_node
    
    def initialize(id, args)
      @id   = id
      @tags = args[:tags]
      @lat  = args[:lat]
      @lon  = args[:lon]
      @karlsruhe_node = Node.new(*args[:karlsruhe_node]) if args[:karlsruhe_node]
    end
  end
end
