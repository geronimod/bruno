module Bruno
  # this must to go in Parosm
  class Way
    attr_reader :id, :nodes, :tags
    
    def initialize(id, args)
      @id    = id
      @nodes = args[:nodes]
      @tags  = args[:tags]
    end
  end
end  