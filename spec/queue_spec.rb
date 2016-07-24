require 'rspec'
require 'adt_utilit/queue'

describe "Queue" do
  let(:empty_queue){ Queue.new }
  let(:single_queue){ Queue.new("merci") }
  let(:queue){ Queue.new([1,2,3,4,5]) }
  describe "Queue::initialize" do
    it "initializes with no argument and creates an empty Queue" do
      expect(empty_queue.length).to eq(0)
    end
    it "initializes with a single value and creates a Queue with the value" do
      expect(single_queue.length).to eq(1)
    end
    it "initializes with an array, and creates a Queue with the elements in the array" do
      expect(queue.length).to eq(5)

    end
  end

  describe "Queue#peek" do
    it "returns the first element of the Queue" do
      expect(single_queue.peek).to eq("merci")
      expect(queue.peek).to eq(1)
    end

    it "returns nil if the Queue is empty" do
      expect(empty_queue.peek).to eq(nil)
    end
  end

  describe "Queue#last" do
    it "returns the endmost value" do
      expect(single_queue.last).to eq("merci")
      expect(queue.last).to eq(5)
    end
    it "returns nil if the Queue is empty" do
      expect(empty_queue.last).to eq(nil)
    end
  end

  describe "Queue#enqueue" do
    it "insert the value to the end of the Queue" do
      queue.enqueue(6)
      expect(queue.last).to eq(6)
      expect(queue.length).to eq(6)
    end

    it "insert the value to an empty Queue" do
      empty_queue.enqueue("wow")
      expect(empty_queue.last).to eq("wow")
      expect(empty_queue.length).to eq(1)
    end
  end

  describe "Queue#dequeue" do
    it "removes the value from the beginning of the Queue" do
      queue.dequeue
      expect(queue.length).to eq(4)
    end

    it "returns the removed value" do
      first = queue.peek
      removed = queue.dequeue
      expect(removed).to be(first)
    end
    it "returns nil if the Queue is empty" do
      expect(empty_queue.dequeue).to eq(nil)
    end

  end

  describe 'Queue#each' do
    it "takes a block and yeilds the block for every element in the Queue" do
      array = []
      queue.each {|value| array << value }
      expect(array).to eq([1,2,3,4,5])
    end
  end

end
