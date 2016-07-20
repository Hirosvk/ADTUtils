require 'rspec'
require 'linked_list.rb'

describe 'LinkedList' do
  subject(:linked_list) { LinkedList.new(["sad", "happy", "happy", "ok"]) }
  let(:hash_linked_list) { LinkedList.new({ triste: "sad", feliz: "happy", ok: "ok" }) }
  let(:single_linked_list) { LinkedList.new("joyful") }
  let(:node) { LinkedListNode.new("awesome") }

  describe 'LinkedList#each' do
    it "takes a block and yeilds the block for every element in the Linked List" do
      array = []
      linked_list.each {|node| array << node.value }
      expect(array).to eq(["sad", "happy", "happy", "ok"])
    end
  end

  describe 'LinkedList::initialize' do
    it 'when give a single value, it creates a single-node Linked List' do
      expect(single_linked_list.length).to eq(1)
      expect(single_linked_list.head.value).to eq("joyful")
    end

    it "when given an array, it creates a multi-node List" do
      expect(linked_list.length).to eq(4)
      expect(linked_list.map(&:value)).to eq(["sad", "happy", "happy", "ok"])
    end

    it "when givin a hash, it stores each pair in the node" do
      expect(hash_linked_list.length).to eq(3)
      expect(hash_linked_list.head.value).to eq({triste: "sad"})
    end
  end

  describe 'LinkedList#head, LinkedList#tail' do
    it "if the Linked List has only one node, head and tail are the first node" do
      expect(single_linked_list.head).to eq(single_linked_list.tail)
    end

  end

  describe 'LinkedList#[]' do
    it "returns the node of the positive index" do
      expect(linked_list[0].value).to eq("sad")
    end
    it "returns the node of the negative index" do
      expect(linked_list[-4].value).to eq("sad")
    end
  end

  describe 'LinkedList#push' do
    it 'when a value is given as argument, it pushes a new LinkedListNode withe the value' do
      linked_list.push("joyful")
      expect(linked_list.tail.class).to be(LinkedListNode)
      expect(linked_list.tail.value).to eq("joyful")
    end

    it "when a LinkedListNode is given as argument, it pushes the node" do
      linked_list.push(node)
      expect(linked_list.tail).to be(node)
    end

    it 'handles the next/prev relationships' do
      old_tail = linked_list.tail
      linked_list.push(node)
      expect(old_tail.next).to eq(node)
      expect(node.prev).to eq(old_tail)
    end

    it 'increment the length by 1' do
      linked_list.push(node)
      expect(linked_list.length).to eq(5)
    end
  end

  describe 'LinkedList#unshift' do
    it 'when a value is given as argument, it unshifts a new LinkedListNode withe value' do
      linked_list.unshift("joyful")
      expect(linked_list.head.class).to be(LinkedListNode)
      expect(linked_list.head.value).to eq("joyful")
    end

    it "when a LinkedListNode is given as argument, it unshifts the node" do
      linked_list.unshift(node)
      expect(linked_list.head).to be(node)
    end

    it 'handles the next/prev relationships' do
      old_head = linked_list.head
      linked_list.unshift(node)
      expect(old_head.prev).to eq(node)
      expect(node.next).to eq(old_head)
    end

    it 'increases the length by 1' do
      linked_list.push(node)
      expect(linked_list.length).to eq(5)
    end

  end

  describe 'LinkedList#pop' do
    before(:each) {
      @old_tail = linked_list.tail
      @popped_node = linked_list.pop
    }
    it "removes the last node" do
      expect(linked_list.length).to eq(3)
      expect(linked_list.tail).to_not eq(@old_tail)
    end

    it 'handles the next/prev relationships' do
      expect(linked_list.tail.next).to eq(nil)
    end

    it 'returns the tail node' do
      expect(@popped_node).to be(@old_tail)
    end
  end

  describe 'LinkedList#shift' do
    before(:each) {
      @old_head = linked_list.head
      @shifted_node = linked_list.shift
    }
    it "removes the last node" do
      expect(linked_list.length).to eq(3)
      expect(linked_list.head).to_not eq(@old_head)
    end

    it 'handles the next/prev relationships' do
      expect(linked_list.head.prev).to eq(nil)
    end

    it 'returns the head node' do
      expect(@shifted_node).to be(@old_head)
    end
  end


  describe 'LinkedList#find' do
    it 'returns the first node whose value is the argument' do
      expect(linked_list.find("happy")).to be(linked_list[1])
    end

    it 'returns nil if no node is found' do
      expect(linked_list.find("angry")).to eq(nil)
    end
  end


  describe 'LinkedList#insert' do

    it 'when a LinkedListNode is given as argument, add a Node to the LinkedList at the index' do
      linked_list.insert(node, 2)
      expect(linked_list[2]).to be(node)
      expect(linked_list.length).to eq(5)
    end

    it 'when a value is given as argument, it inserts a new LinkedListNode withe value' do
      linked_list.insert("joyful", 2)
      expect(linked_list[2].class).to eq(LinkedListNode)
      expect(linked_list[2].value).to eq("joyful")
      expect(linked_list.length).to eq(5)
    end

    it 'handles prev/next relationships' do
      linked_list.insert(node, 2)
      expect(linked_list[1].next).to be(node)
      expect(node.prev).to be(linked_list[1])
      expect(linked_list[3].prev).to be(node)
      expect(node.next).to be(linked_list[3])
    end

    it 'inserts at idx=0 and updates the head' do
      linked_list.insert(node, 0)
      expect(linked_list.head).to be(node)
    end

    it 'inserts at idx=(-length) and updates the head' do
      linked_list.insert(node, -4)
      expect(linked_list.head).to be(node)
    end

    it 'inserts at idx=-1 and updates the tail' do
      linked_list.insert(node, -1)
      expect(linked_list.tail).to be(node)
    end

    it 'inserts at idx=length-1 and updates the tail' do
      linked_list.insert(node, 3)
      expect(linked_list.tail).to be(node)
    end

  end


  describe 'LinkedList#find_all' do
    it 'returns all nodes whose value is the argument as a array' do
      expect(linked_list.find_all("happy").is_a?(Array)).to be(true)
      expect(linked_list.find_all("happy").map(&:value)).to eq(["happy", "happy"])
    end

    it 'returns nil if no node is found' do
      expect(linked_list.find("angry")).to eq(nil)
    end
  end

  describe 'LinkedList#remove_all' do
    it 'if the value is found, removes all the nodes with the value' do
      linked_list.remove_all("happy")
      expect(linked_list.length).to eq(2)
      expect(linked_list.map(&:value)).to eq(["sad", "ok"])
    end

    it 'returns the value if any value is removed' do
      expect(linked_list.remove_all("happy")).to eq(true)
    end

    it 'returns nil if no node is found' do
      expect(linked_list.remove_all("angry")).to eq(false)
    end
  end

  describe 'LinkedList#remove_at' do
    it 'removes the nodes at the index' do
      linked_list.remove_at(2)
      expect(linked_list.length).to eq(3)
      expect(linked_list.map(&:value)).to eq(["sad", "happy", "ok"])
    end

    it 'returns the index, if the node is removed' do
      expect(linked_list.remove_at(2)).to eq(2)
    end

    it 'returns nil if no node is found' do
      expect(linked_list.remove_at(6)).to eq(nil)
    end

    it 'removes at idx=0 and updates the head' do
      head_to_be = linked_list[1]
      linked_list.remove_at(0)
      expect(linked_list.head).to be(head_to_be)
    end

    it 'removes at idx=(-length) and updates the head' do
      head_to_be = linked_list[1]
      linked_list.remove_at(-4)
      expect(linked_list.head).to be(head_to_be)
    end

    it 'removes at idx=-1 and updates the tail' do
      tail_to_be = linked_list[-2]
      linked_list.remove_at(-1)
      expect(linked_list.tail).to be(tail_to_be)
    end

    it 'inserts at idx=length-1 and updates the tail' do
      tail_to_be = linked_list[-2]
      linked_list.remove_at(3)
      expect(linked_list.tail).to be(tail_to_be)
    end

  end

end
