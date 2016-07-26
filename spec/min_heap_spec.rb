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

    heap.send(:get_last_parent)
    heap.send(:get_last_node)
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
      expect(heap.last_parent.value).to eq(55)
      expect(heap.last.value).to eq(7)
    end
    it "inserts new value" do
      heap.insert(2)
      expect(heap.get_min).to eq(2)
    end
  end

  describe "#remove_min" do
    it "returns the value of the root node" do
      min = heap.remove_min
      expect(min).to eq(4)
    end

    it "removes the root node" do
      heap.remove_min
      expect(heap.get_min).to_not eq(4)
    end

    it "updates the root with the new minimum" do
      heap.remove_min
      expect(heap.get_min).to eq(7)
    end

    it "updates the node" do
      heap.insert(30)
      heap.remove_min
      expect(heap.get_min).to eq(7)
      expect(heap.last_parent.value).to eq(30)
      expect(heap.last.value).to eq(87)
    end
  end

end
