require "rspec"
require "adt_utilit/graph_node_weighed"

describe GraphNodeWeighed do
  subject(:node_a){ GraphNodeWeighed.new("a") }
  let(:node_b)   { GraphNodeWeighed.new("b") }
  let(:node_c)    { GraphNodeWeighed.new("c") }
  let(:node_d)  { GraphNodeWeighed.new("d") }
  let(:node_e)   { GraphNodeWeighed.new("e") }
  let(:node_f)   { GraphNodeWeighed.new("f") }
  let(:node_g)   { GraphNodeWeighed.new("g") }
  let(:node_h)   { GraphNodeWeighed.new("h") }
  let(:node_i)   { GraphNodeWeighed.new("i") }

  before(:each) {
    node_a.connect(node_b, 5)
    node_a.connect(node_c, 3)
    node_a.connect(node_e, 2)

    node_b.connect(node_d, 2)

    node_c.connect(node_b, 1)
    node_c.connect(node_d, 1)

    node_d.connect(node_a, 1)
    node_d.connect(node_g, 2)
    node_d.connect(node_h, 1)

    node_e.connect(node_a, 1)
    node_e.connect(node_h, 4)
    node_e.connect(node_i, 7)

    node_f.connect(node_b, 3)
    node_f.connect(node_g, 1)

    node_g.connect(node_c, 3)
    node_g.connect(node_i, 2)

    node_h.connect(node_c, 2)
    node_h.connect(node_g, 2)
    node_h.connect(node_f, 2)
  }
  describe "#children" do
    it "returns an array whose first element is the child, and the second element is the weight" do
      expect(node_a.children).to eq([[node_b, 5], [node_c, 3], [node_e, 2]])
    end
  end

  describe "#weight" do
    it "returns the weight of the edge from the receiver node to the argument node" do
      expect(node_b.weight(node_d)).to eq(2)
    end
    it "can take the value instead of the node" do
      expect(node_e.weight("i")).to eq(7)
    end

    it "returns nil if there is no edge to the node or value" do
      expect(node_a.weight(node_i)).to eq(nil)
      expect(node_e.weight("f")).to eq(nil)
    end
  end

  describe "#connect" do
    it "raises error unless the weight is integer"
  end

  describe "#shortest_path_to" do
    it "returns the shortest path" do
      expect(node_a.shortest_path_to(node_i)).to eq(["a", "c", "d", "g", "i"])
      debugger
    end
  end

  describe "#shortest_paths_to_all_nodes" do
    it "returns a map of the shortest distance to each node" do
      result = node_a.shortest_paths_to_all_nodes
      expect(result["b"]).to eq([4, "c"])
      expect(result["i"]).to eq([8, "g"])
      expect(result["h"]).to eq([5, "d"])
    end
  end

end
