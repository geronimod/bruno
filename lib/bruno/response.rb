module Bruno
  class Response
    attr_reader :way, :ways, :nodes, :success, :housenumber

    def initialize(options = {})
      @ways  = Array(options[:ways]).map { |w| Way.new(*w) }
      @way   = @ways.first if @ways.size == 1
      @nodes = options[:nodes] && options[:nodes].compact || []
      @housenumber = options[:housenumber]

      if @nodes.empty?
        @success = @ways.any?
      else
        @success = @nodes.any?
        @nodes   = @nodes.map { |node| Node.new *node }
      end
    end

    def success?
      @success
    end

    def way_ids
      @ways.map &:id
    end

    def way_nodes
      @ways.map &:nodes
    end

    def node_ids
      @nodes.map &:id
    end

    def closest_node
      @nodes.sort_by do |n| 
        (n.karlsruhe_node.tags[:"addr:housenumber"].to_i - housenumber.to_i).abs 
      end.first
    end

  end
end