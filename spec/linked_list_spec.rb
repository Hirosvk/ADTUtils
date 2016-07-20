require 'rspec'
require 'linked_list.rb'

describe 'LinkedList' do
  subject(:linked_list) { LinkedList.new(["sad", "happy", "happy", "ok"]) }
  let(:single_linked_list) { LinkedList.new("joyful") }
  let(:node) { LinkedListNode.new("awesome") }

  describe 'LinkedList::initialize' do
    it 'when give a single value, it creates a single-node Linked List' do
      expect(single_linked_list.length).to eq(1)
      expect(single_linked_list.head.value).to eq("joyful")
    end

    it "when given an array, it creates a multi-node List" do
      expect(linked_list.length).to eq(4)
    end

    it "s each node's value correspods the value of the array element" do
      expect(linked_list.values).to eq(["sad", "happy", "happy", "ok"])
    end
  end


  describe 'LinkedList#head, LinkedList#tail' do
    it "if the Linked List has only one node, head and tail are the first node" do
      expect(single_linked_list.head).to eq(single_linked_list.tail)
    end

  end

  describe 'LinkedList#push' do
    it 'when a value is given as argument, it pushes a new LinkedListNode withe value' do
      linked_list.push("joyful")
      expect(linked_list.tail.class).to be("LinkedListNode")
      expect(linked_list.tail.value).to be("joyful")
    end

    it "when a LinkedListNode is given as argument, it pushes the node" do
      linked_list.push(single_linked_list)
      expect(linked_list.tail).to be(single_linked_list)
    end

    it 'handles the next/prev relationships' do
      old_tail = linked_list.tail
      linked_list.push(single_linked_list)
      expect(old_tail.next).to eq(single_linked_list)
      expect(single_linked_list.prev).to eq(old_tail)
    end
  end

  describe 'LinkedList#unshift' do
    it 'when a value is given as argument, it unshifts a new LinkedListNode withe value' do
      linked_list.unshift("joyful")
      expect(linked_list.head.class).to be("LinkedListNode")
      expect(linked_list.head.value).to be("joyful")
    end

    it "when a LinkedListNode is given as argument, it unshifts the node" do
      linked_list.unshift(single_linked_list)
      expect(linked_list.head).to be(single_linked_list)
    end

    it 'handles the next/prev relationships' do
      old_head = linked_list.head
      linked_list.unshift(single_linked_list)
      expect(old_head.prev).to eq(single_linked_list)
      expect(single_linked_list.next).to eq(old_head)
    end
  end

  describe 'LinkedList#pop' do
    before(:each) {
      old_tail = linked_list.tail
      popped_node = linked_list.pop
    }
    it "removes the last node" do
      expect(linked_list.length).to eq(3)
      expect(linked_list.tail).to_not eq(old_tail)
    end

    it 'handles the next/prev relationships' do
      expect(linked_list.tail.next).to eq(nil)
    end

    it 'returns the tail node' do
      expect(popped_node).to eq(old_tail)
    end
  end

  describe 'LinkedList#shift' do
    before(:each) {
      old_head = linked_list.head
      shifted_node = linked_list.shift
    }
    it "removes the last node" do
      expect(linked_list.length).to eq(3)
      expect(linked_list.head).to_not eq(old_head)
    end

    it 'handles the next/prev relationships' do
      expect(linked_list.head.next).to eq(nil)
    end

    it 'returns the head node' do
      expect(shifted_node).to eq(old_head)
    end
  end


  describe 'LinkedList#find' do
    it 'takes a value as an argument' do
      expect{linked_list.find("happy")}.to_not raise_error
    end

    it 'returns the first node whose value is the argument' do
      expect(linked_list.find("happy")).to eq(linked_list[1])
    end

    it 'returns nil if no node is found' do
      expect(linked_list.find("angry")).to eq(nil)
    end
  end

  describe 'LinkedList#find_all' do
    it 'takes a value as an argument' do
      expect{linked_list.find_all("happy")}.to_not raise_error
    end

    it 'returns all nodes whose value is the argument as a array' do
      expect(linked_list.find_all("happy").is_a?(Array)).to be(true)
      expect(linked_list.find_all("happy").map(&:value)).to eq(["happy", "happy"])
    end

    it 'returns nil if no node is found' do
      expect(linked_list.find("angry")).to eq(nil)
    end
  end


  describe 'LinkedList#remove_all' do
    it 'takes a value as an argument' do
      expect{linked_list.remove_all("happy")}.to_not raise_error
    end

    it 'if the value is found, removes all the nodes with the value' do
      linked_list.remove_all("happy")
      expect(linked_list.length).to eq(2)
      expect(linked_list.map(&:value)).to eq(["sad", "ok"])
    end

    it 'returns the value if any value is removed' do
      expect(linked_list.remove_all("happy")).to eq("happy")
    end

    it 'returns nil if no node is found' do
      expect(linked_list.remove_all("angry")).to eq(nil)
    end
  end

  describe 'LinkedList#insert' do
    before(:each) { linked_list.insert(node, 2) }

    it 'add a Node to the LinkedList at the index' do
      expect(linked_list[2]).to be(node)
      expect(linked_list.length).to eq(5)
    end

    it 'handles prev/next relationships' do
      expect(linked_list[1].next).to be(node)
      expect(node.prev).to be(linked_list[1])
      expect(linked_list[3].prev).to be(node)
      expect(node.next).to be(linked_list[3])
    end

    it "shifts the all preceeding Nodes' indices by one" do
      expect(linked_list.find("ok").index).to eq(4)
    end

  end


  describe 'LinkedList#concat' do
  end

  describe 'LinkedList#each' do
    it "takes a block and yeilds the block for every element in the Linked List" do

    end
  end


end
