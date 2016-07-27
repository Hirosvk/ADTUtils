require "rspec"
require "adt_utilit/binary_tree_node"

describe BinaryTreeNode do
  let(:tree_node_1){ BinaryTreeNode.new(1) }
  let(:tree_node_2){ BinaryTreeNode.new(2) }
  let(:tree_node_3){ BinaryTreeNode.new(3) }
  let(:tree_node_4){ BinaryTreeNode.new(4) }
  let(:tree_node_5){ BinaryTreeNode.new(5) }
  let(:tree_node_6){ BinaryTreeNode.new(6) }
  let(:tree_node_7){ BinaryTreeNode.new(7) }

  describe "#initialize" do
    it "initializes with a value" do
      expect(tree_node_1.value).to eq(1)
    end
    it "children are empty" do
      expect(tree_node_1.children.length).to eq(0)
    end
  end

  # describe "#parent" do
  #   it "returns parent node" do
  #     tree_node_1.connect(tree_node_2)
  #     expect(tree_node_2.parent).to be(tree_node_1)
  #   end
  #
  #   it "returns nil if the node has no parent" do
  #     expect(tree_node_3.parent).to eq(nil)
  #   end
  # end

  describe "#left_child" do
    it "returns nil if children is empty" do
      expect(tree_node_1.left_child).to eq(nil)
    end

    it "when a node is connected to an empty node, it becomes the left_child" do
      tree_node_1.connect(tree_node_2)
      expect(tree_node_1.left_child).to be(tree_node_2)
    end

    it "when a second node is connected, it become the right_chld" do
      tree_node_1.connect(tree_node_2)
      tree_node_1.connect(tree_node_5)
      expect(tree_node_1.right_child).to be(tree_node_5)
    end

    it "when the left_child is removed, the right_child becomes the left_child"do
    tree_node_1.connect(tree_node_2)
    tree_node_1.connect(tree_node_5)
    tree_node_1.remove(tree_node_2)
    expect(tree_node_1.left_child).to be(tree_node_5)
    end
  end

  # describe "#right_child" do
  #   it "returns nil if children is empty" do
  #     tree_node_1.connect(tree_node_5)
  #     expect(tree_node_1.right_child).to eq(nil)
  #   end
  #
  #   it "is the second child of the node" do
  #     tree_node_1.connect(tree_node_2)
  #     tree_node_1.connect(tree_node_5)
  #     expect(tree_node_1.right_child).to be(tree_node_5)
  #   end
  # end

  describe "#connect" do
    it "raises error when adding more than two nodes" do
      tree_node_1.connect(tree_node_2)
      tree_node_1.connect(tree_node_5)
      expect{ tree_node_1.connect(tree_node_6) }.to raise_error("BinaryTreeNode can have only two children")
    end

    it "does not allow undirected edges" do
      tree_node_1.connect(tree_node_2)
      expect{ tree_node_2.connect(tree_node_1) }.to raise_error("Undirected edges are not allowed in binary tree")
    end
  end


  describe "#filled?" do
    it "returns true if the node has two children" do
      tree_node_1.connect(tree_node_2)
      tree_node_1.connect(tree_node_5)
      expect(tree_node_1.filled?).to eq(true)
    end

    it "returns false if the node has one or zero children" do
      expect(tree_node_1.filled?).to eq(false)
      tree_node_1.connect(tree_node_2)
      expect(tree_node_1.filled?).to eq(false)
    end
  end

  describe "#bfs" do
    before(:each) {
      tree_node_1.connect(tree_node_2)
      tree_node_2.connect(tree_node_3)
      tree_node_2.connect(tree_node_4)
      tree_node_1.connect(tree_node_5)
      tree_node_5.connect(tree_node_6)
      tree_node_5.connect(tree_node_7)
    }
    it "searches the value, and returns the GraphNode" do
      result = tree_node_1.bfs(4)
      expect(result).to be(tree_node_4)
    end

    it "searches the condition, and returns the first GraphNode" do
      result = tree_node_1.bfs{ |val| val % 5 == 0 }
      expect(result).to be(tree_node_5)
    end

    it "searches the closest node to the beginning node" do
      result = tree_node_1.bfs{ |val| val > 3 && val < 6 }
      expect(result).to be(tree_node_5)
    end

    it "returns nil if no node was found" do
      result = tree_node_1.bfs(10)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ tree_node_1.bfs(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ tree_node_1.bfs }.to raise_error("Wrong number of argument")
    end

  end

  describe "#trav_in_order" do
    before(:each) {
      tree_node_1.connect(tree_node_2)
      tree_node_2.connect(tree_node_3)
      tree_node_2.connect(tree_node_4)
      tree_node_1.connect(tree_node_5)
      tree_node_5.connect(tree_node_6)
      tree_node_5.connect(tree_node_7)
    }
    it "searches the value, and returns the GraphNode" do
      result = tree_node_1.trav_in_order(4)
      expect(result).to be(tree_node_4)
    end

    it "searches the condition, and returns the first GraphNode" do
      result = tree_node_1.trav_in_order{ |val| val % 5 == 0 }
      expect(result).to be(tree_node_5)
    end

    it "returns nil if no node was found" do
      result = tree_node_1.trav_in_order(10)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ tree_node_1.trav_in_order(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ tree_node_1.trav_in_order }.to raise_error("Wrong number of argument")
    end

    it "searches the node in the right order" do
      result = tree_node_1.trav_in_order{|val| val > 1}
      expect(result).to be(tree_node_3)
      result = tree_node_1.trav_in_order{|val| val % 2 == 0}
      expect(result).to be(tree_node_2)
    end

  end

  describe "#trav_pre_order" do
    before(:each) {
      tree_node_1.connect(tree_node_2)
      tree_node_2.connect(tree_node_3)
      tree_node_2.connect(tree_node_4)
      tree_node_1.connect(tree_node_5)
      tree_node_5.connect(tree_node_6)
      tree_node_5.connect(tree_node_7)
    }
    it "searches the value, and returns the GraphNode" do
      result = tree_node_1.trav_pre_order(4)
      expect(result).to be(tree_node_4)
    end

    it "searches the condition, and returns the first GraphNode" do
      result = tree_node_1.trav_pre_order{ |val| val % 5 == 0 }
      expect(result).to be(tree_node_5)
    end

    it "returns nil if no node was found" do
      result = tree_node_1.trav_pre_order(10)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ tree_node_1.trav_pre_order(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ tree_node_1.trav_pre_order }.to raise_error("Wrong number of argument")
    end

    it "searches the node in the right order" do
      result = tree_node_1.trav_pre_order{|val| val < 5}
      expect(result).to be(tree_node_1)
    end
  end

  describe "#trav_post_order" do
    before(:each) {
      tree_node_1.connect(tree_node_2)
      tree_node_2.connect(tree_node_3)
      tree_node_2.connect(tree_node_4)
      tree_node_1.connect(tree_node_5)
      tree_node_5.connect(tree_node_6)
      tree_node_5.connect(tree_node_7)
    }
    it "searches the value, and returns the GraphNode" do
      result = tree_node_1.trav_post_order(4)
      expect(result).to be(tree_node_4)
    end

    it "searches the condition, and returns the first GraphNode" do
      result = tree_node_1.trav_post_order{ |val| val % 5 == 0 }
      expect(result).to be(tree_node_5)
    end

    it "returns nil if no node was found" do
      result = tree_node_1.trav_post_order(10)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ tree_node_1.trav_post_order(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ tree_node_1.trav_post_order }.to raise_error("Wrong number of argument")
    end

    it "searches the node in the right order" do
      result = tree_node_1.trav_post_order{|val| val > 1}
      expect(result).to be(tree_node_3)
      result = tree_node_1.trav_post_order{|val| val % 2 == 0}
      expect(result).to be(tree_node_4)
    end

  end


  # describe "#switch" do
  #   before(:each) {
  #     tree_node_1.connect(tree_node_2)
  #     tree_node_2.connect(tree_node_3)
  #     tree_node_2.connect(tree_node_4)
  #     tree_node_1.connect(tree_node_5)
  #     tree_node_5.connect(tree_node_6)
  #     tree_node_5.connect(tree_node_7)
  #   }
  #   it "raise an error unless parent-child relationship exists"  do
  #     expect{ tree_node_1.switch(tree_node_7) }.to raise_error("No parent-child relationship exists")
  #   end
  #
  #   it "switch the position in tree" do
  #     tree_node_1.switch(tree_node_5)
  #     expect(tree_node_5.right_child).to be(tree_node_1)
  #     expect(tree_node_1.left_child).to be(tree_node_6)
  #     expect(tree_node_1.right_child).to be(tree_node_7)
  #   end
  # end

end
