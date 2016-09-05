require 'rspec'
require 'adt_utilit/graph_node'

describe "GraphNode" do
  subject(:graph_node_one){ GraphNode.new(1) }
  let(:graph_node_zero)   { GraphNode.new(0) }
  let(:graph_node_two)    { GraphNode.new(2) }
  let(:graph_node_three)  { GraphNode.new(3) }
  let(:graph_node_four)   { GraphNode.new(4) }
  let(:graph_node_five)   { GraphNode.new(5) }
  describe "#initialize" do
    it "initializes with one argument" do
      expect(graph_node_one.value).to eq(1)
    end
  end


  describe "#connect" do
    before(:each) {graph_node_one.connect(graph_node_two)}
    it "creates a directed edge from the receiver node to the argument node" do
      expect(graph_node_one.children).to include(graph_node_two)
    end

    it "adds multiple GraphNodes as chlildren" do
      graph_node_one.connect(graph_node_three)
      expect(graph_node_one.children).to include(graph_node_two)
      expect(graph_node_one.children).to include(graph_node_three)
    end
  end

  describe "#remove" do
    before(:each) {
      graph_node_one.connect(graph_node_two)
      graph_node_one.connect(graph_node_three)
    }
    it "removes the GraphNode" do
      graph_node_one.remove(graph_node_two)
      expect(graph_node_one.children).to_not include(graph_node_two)
    end

    it "returns the removed GraphNodes" do
      removed_node = graph_node_one.remove(graph_node_two)
      expect(removed_node).to be(graph_node_two)
    end

    it "returns nil if the node was not found" do
      return_value = graph_node_one.remove(graph_node_four)
      expect(return_value).to eq(nil)
    end
  end

  describe "remove_all" do
    before(:each) {
      graph_node_one.connect(graph_node_two)
      graph_node_one.connect(graph_node_three)
    }
    it "removes all children nodes" do
      graph_node_one.remove_all
      expect(graph_node_one.children.length).to eq(0)
    end
  end

  describe "#bsf" do
    before(:each) {
      graph_node_zero.connect(graph_node_five)
      graph_node_zero.connect(graph_node_four)
      graph_node_zero.connect(graph_node_one)

      graph_node_one.connect(graph_node_four)
      graph_node_one.connect(graph_node_three)

      graph_node_three.connect(graph_node_four)
      graph_node_three.connect(graph_node_two)

      graph_node_two.connect(graph_node_one)
    }
    it "searches the value, and returns the GraphNode" do
      result = graph_node_zero.bfs(4)
      expect(result).to be(graph_node_four)
    end

    it "searches the condition, and returns the first GraphNode" do
      result = graph_node_zero.bfs{ |val| val > 4 }
      expect(result).to be(graph_node_five)
    end

    it "searches the closest node to the beginning node" do
      result = graph_node_zero.bfs{ |val| val > 2 && val < 5 }
      expect(result).to be(graph_node_four)
    end

    it "returns nil if no node was found" do
      result = graph_node_zero.bfs(7)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ graph_node_zero.bfs(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ graph_node_zero.bfs }.to raise_error("Wrong number of argument")
    end

  end

  describe "#dfs" do
    before(:each) {
      graph_node_zero.connect(graph_node_five)
      graph_node_zero.connect(graph_node_four)
      graph_node_zero.connect(graph_node_one)

      graph_node_one.connect(graph_node_four)
      graph_node_one.connect(graph_node_three)

      graph_node_three.connect(graph_node_four)
      graph_node_three.connect(graph_node_two)

      graph_node_two.connect(graph_node_one)
    }
    it "searches the value, and returns the GraphNode" do
      result = graph_node_zero.dfs(4)
      expect(result).to be(graph_node_four)
    end
    it "searches the condition, and returns the first GraphNode" do
      result = graph_node_zero.dfs{ |val| val > 4 }
      expect(result).to be(graph_node_five)
    end

    it "returns nil if no node was found" do
      result = graph_node_zero.dfs(7)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ graph_node_zero.dfs(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ graph_node_zero.dfs }.to raise_error("Wrong number of argument")
    end
  end

end
