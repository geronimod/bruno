# encoding: utf-8
require "bruno/version"
require "bruno/node"
require "bruno/way"
require "bruno/response"
require "bruno/utils"

module Bruno
  class Finder

    attr_reader :osm_file, :options

    # abbreviations
    ABBR_REXP = /^[a-z]{1,3}+\.\s/i

    def initialize(osm_file, options = {})
      @options = options
      @osm = Parosm::Loader.new osm_file, cache: true
    end

    def find(street, housenumber = nil)
      ways = candidate_ways street
      disambiguate! ways, street
      
      street_name = ways.first.last[:tags][:name]

      if housenumber
        nodes = karlsruhe_find(ways, street_name, housenumber)
        Response.new ways: ways, nodes: nodes, housenumber: housenumber
      else
        Response.new ways: ways
      end
    end

    # Karlsruhe_Schema http://wiki.openstreetmap.org/wiki/Karlsruhe_Schema
    def karlsruhe_find(ways, street, housenumber)
      karlsruhe_nodes =   karlsruhe_find_by_node street, housenumber
      karlsruhe_nodes ||= karlsruhe_find_by_interpolation street, housenumber
      find_routeable_nodes ways, karlsruhe_nodes
    end

    def find_routeable_nodes(ways, karlsruhe_nodes)
      routeable_nodes = ways.map { |id, int| int[:nodes] }.flatten
      
      Array(karlsruhe_nodes).map do |karlsruhe_node|
        routeable_node = routeable_nodes.min_by do |node_id|
          Utils.distance @osm.nodes[node_id], karlsruhe_node.last
        end
        [routeable_node, @osm.nodes[routeable_node].merge(karlsruhe_node: karlsruhe_node)]
      end
    end

    def karlsruhe_find_by_node(street, housenumber)
      @osm.nodes.find do |node|
        tags = node.last[:tags]
        tags[:"addr:street"] == street && tags[:"addr:housenumber"] == housenumber
      end
    end

    def karlsruhe_find_by_interpolation(street, housenumber)
      candidate_nodes = @osm.nodes.find_all do |node|
        node_id, internals = node
        tags = internals[:tags]
        tags[:"addr:street"] == street && tags[:"addr:housenumber"] && belongs_to_interpolation?(node_id, housenumber)
      end

      nodes_by_proximity candidate_nodes, housenumber
    end

    private

    def nodes_by_proximity(nodes, housenumber)
      sorted_nodes = nodes.sort_by do |id, internals| 
        internals[:tags][:"addr:housenumber"].to_i 
      end

      # proximity nodes
      [].tap do |out|
        sorted_nodes.each_with_index do |n, ix|
          id, internals = n

          if internals[:tags][:"addr:housenumber"].to_i > housenumber.to_i
            out << nodes[ix-1] if ix > 0
            out << nodes[ix]
          end
        end
      end.first(2)
    end

    def interpolation_type(housenumber)
      housenumber.to_i.odd? ? :odd : :even
    end

    def belongs_to_interpolation?(node_id, housenumber)
      i = @osm.ways.find do |id, internals|
        nodes, tags = internals[:nodes], internals[:tags]
        nodes.include?(node_id) && tags[:"addr:interpolation"].to_sym == interpolation_type(housenumber)
      end
      
      i && i.any?
    end

    def disambiguate!(ways, street)
      ways.delete_if do |way|
        # add more rules as necesary
        name = way.last[:tags][:name]
        cleared_street(street) != cleared_street(name)
      end
    end

    def candidate_ways(street)
      _street = cleared_street street
      
      @osm.ways.find_all do |w|
        tags = w.last[:tags]
        if tags[:highway] && tags[:name]
          name = cleared_street tags[:name]
          name =~ /#{_street}/i
        end
      end
    end

    def has_abbr?(name)
      ABBR_REXP === name
    end

    def cleanup_abbr(name)
      name.gsub(ABBR_REXP, '')
    end

    def cleared_street(name)
      cleanup_abbr name.strip
                       .downcase
                       .tr('áéíóú','aeiou')
    end


  end


end
