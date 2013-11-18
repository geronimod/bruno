require 'spec_helper'
require 'parosm'
require 'bruno'

describe Bruno do

  def spec_osm_file
    File.join File.dirname(__FILE__), "20130810-tandil.osm"
  end

  before :each do
    @bruno = Bruno::Finder.new spec_osm_file
  end

  it "should not fail when it does't find the way" do
    response = @bruno.find "ghost street"
    response.success?.should be_false
  end

  it "should find only one street" do
    response = @bruno.find "San Martin"
    response.success?.should be_true
    response.ways.count.should eq 1
    response.way.id.should eq "38103609"
    response.way.nodes.should eq [
      "448193318", "448193317", "448193315", "448193314", "448193313", 
      "448193312", "448193311", "448193310", "448193051", "448193309", 
      "448193307", "448193306", "453397921", "448193302", "448193301", 
      "448193300", "448193298", "448193297", "448193295"
    ]
  end

  it "should find more than one ways" do
    response = @bruno.find "picheuta"
    response.success?.should be_true
    response.ways.count.should eq 3
    response.way_ids.should eq ["120314075", "120314089", "129171607"]
    response.way_nodes.should eq [
      ["1349293076", "1349293067", "1349276791", "1349293077"], 
      ["1349293105", "1349293106", "1349293107"], 
      ["448193444", "1349293082"]
    ]
  end

  it "should find the closest node for different cases" do
    response = @bruno.find "San Martin", "440"
    response.success?.should be_true
    response.ways.count.should eq 1
    response.node_ids.should eq ["448193301", "448193302"]
    response.closest_node.id.should eq "448193301"

    response = @bruno.find "San Martin", "100"
    response.success?.should be_true
    response.ways.count.should eq 1
    response.node_ids.should eq ["448193297"]
    response.closest_node.id.should eq "448193297"

    response = @bruno.find "Sarmiento", "198"
    response.success?.should be_true
    response.ways.count.should eq 2
    response.node_ids.should eq ["448193263"]
    response.closest_node.id.should eq "448193263"
  end

end