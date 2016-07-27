require "rspec"
require "adt_utilit/min_heap"

describe MinHeap do
  # let!(:node_4) { BinaryTreeNode.new(4) }
  # let!(:node_50) { BinaryTreeNode.new(50) }
  # let!(:node_55) { BinaryTreeNode.new(55) }
  # let!(:node_90) { BinaryTreeNode.new(90) }
  # let!(:node_7) { BinaryTreeNode.new(7) }
  # let!(:node_87) { BinaryTreeNode.new(87) }
  # let!(:node_2) { BinaryTreeNode.new(2) }
  # subject(:heap) { MinHeap.new(node_4) }
  #
  # before(:each) {
  #   node_4.connect(node_50)
  #   node_4.connect(node_7)
  #
  #   node_50.connect(node_55)
  #   node_50.connect(node_90)
  #
  #   node_7.connect(node_87)
  #
  #   heap.send(:get_last_parent)
  #   heap.send(:get_last_node)
  # }
  subject(:heap){ MinHeap.new() }
  before(:each){
    [4,50,55,90,7,87,2].each {|num| heap.insert(num)}
  }
  describe "#initialize" do
    it "initializes with no argument, and creates an empty heap" do
      expect{ MinHeap.new }.to_not raise_error
      expect(MinHeap.new.length).to eq(0)
    end

    it "initializes with one argument, and it becomes the first value" do
      heap_one = MinHeap.new(2)
      expect(heap_one.length).to eq(1)
      expect(heap_one.get_min).to eq(2)
    end

    it "initializes with an arary, and sort the array" do
      array = [4,50,55,90,7,87,2]
      heap_array = MinHeap.new(array)
      expect(heap_array.get_min).to eq(2)
      expect(heap_array.length).to eq(7)
      # sorted_array = []
      # heap_array.length.times { sorted_array << heap_array.get_min }
      # expect(sorted_array).to eq(array.sort)
    end

  end


  describe "#get_min" do
    it "returns the value of the minimum value" do
      expect(heap.get_min).to eq(2)
    end
  end

  describe "#insert" do
    it "inserts new value and rearrange" do
      heap.insert(0)
      expect(heap.get_min).to eq(0)
    end
  end

  describe "#remove_min" do
    it "returns the value of the minimum value" do
      min = heap.remove_min
      expect(min).to eq(2)
    end

    it "removes the value" do
      heap.remove_min
      expect(heap.length).to eq(6)
    end

    it "updates the root with the new minimum" do
      heap.remove_min
      expect(heap.get_min).to eq(4)
    end
    it "handles the entire array" do
      sorted_array = []
      heap.length.times { sorted_array << heap.remove_min }
      expect(sorted_array).to eq([4,50,55,90,7,87,2].sort)
    end
  end

end
