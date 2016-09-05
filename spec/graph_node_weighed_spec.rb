require "rspec"
require "adt_utilit/graph_node_weighed"

describe GraphNodeWeighed do
  describe "#children" do
    it "returns an array whose first element is the child, and the second element is the weight" do

    end
  end

  describe "#weight" do
    it "returns the weight of the edge from the receiver node to the argument node"
  end

  describe "#connect" do
    it "raises error unless the node is non-weighed"
    it "connects the node with the weight of the edge"
  end


end
