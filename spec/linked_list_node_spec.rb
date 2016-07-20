require 'rspec'
require 'linked_list_node.rb'


describe 'LinkedListNode' do
  subject(:node) {LinkedListNode.new("happy")}
  let(:after_node) {LinkedListNode.new("sad")}
  let(:before_node) {LinkedListNode.new("joyful")}
  let(:other_node) {LinkedListNode.new("wierd")}

  describe 'LinkedListNode::initialize' do
    it "initializes with the value" do
      expect(node.value).to eq("happy")
    end

    it "'next' is nil" do
      expect(node.next).to eq(nil)
    end

    it "'prev' is nil" do
      expect(node.prev).to eq(nil)
    end
  end

  describe 'LinkedListNode#connect' do
    before(:each){
      before_node.connect(node)
      node.connect(after_node)
    }
    it "updates the instance's next to the argument Node" do
      expect(node.next).to be(after_node)
    end

    it "updates the argument Node's prev to the instance" do
      expect(after_node.prev).to be(node)
    end

    it "takes nil as argument, and sets the Node's next as nil" do
      node.connect(nil)
      expect(node.next).to eq(nil)
    end

  end

  describe "LinkedListNode#remove" do
    before(:each){
      before_node.connect(node)
      node.connect(after_node)
    }
    it "connects it's prev with the next" do
      node.remove
      expect(before_node.next).to be(after_node)
      expect(after_node.prev).to be(before_node)
    end

    it "returns the removed node" do
      removed_node = node.remove
      expect(removed_node).to be(node)
    end

  end

end
