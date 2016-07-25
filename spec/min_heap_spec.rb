require "rspec"
require "adt_utilit/min_heap"

describe MinHeap do
  let!(:node_4) { BinaryTreeNode.new(4) }
  let!(:node_50) { BinaryTreeNode.new(50) }
  let!(:node_55) { BinaryTreeNode.new(55) }
  let!(:node_90) { BinaryTreeNode.new(90) }
  let!(:node_7) { BinaryTreeNode.new(7) }
  let!(:node_87) { BinaryTreeNode.new(87) }
  let!(:node_2) { BinaryTreeNode.new(2) }
  subject(:heap) { MinHeap.new(node_4) }

  before(:each) {
    node_4.connect(node_50)
    node_4.connect(node_7)

    node_50.connect(node_55)
    node_50.connect(node_90)

    node_7.connect(node_87)

    heap.send(:get_last)
  }

  describe "#get_min" do
    it "returns the value of the root node" do
      expect(heap.get_min).to eq(4)
    end
  end

  describe "#insert" do
    it "inserts new node and rearrange the tree" do
      heap.insert(node_2)
      expect(heap.get_min).to eq(2)
    end
    it "inserts new value" do
      heap.insert(2)
      expect(heap.get_min).to eq(2)
    end
  end

  describe "#remove_min" do
    it "returns the value of the root node"
    it "removes the root node"
    it "updates the root with the new minimum"
  end

end
