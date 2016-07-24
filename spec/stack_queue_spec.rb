require 'rspec'
require 'adt_utilit/stack_queue'

describe "StackQueue" do
  let(:stack_queue){ StackQueue.new([0, 36, 25, 27, 2]) }
  let(:single_stack_queue) { StackQueue.new("bueno") }
  let(:empty_stack_queue){ StackQueue.new }

  describe "#initialize" do
    it "initializes with no argument and creates an empty Queue" do
      expect(empty_stack_queue.length).to eq(0)
    end
    it "initializes with a single value and creates a Queue with the value" do
      expect(single_stack_queue.length).to eq(1)
    end
    it "initializes with an array, and creates a Queue with the elements in the array" do
      expect(stack_queue.length).to eq(5)

    end
  end

  describe "StackQueue#peek" do
    it "returns the first element of the Queue" do
      expect(single_stack_queue.peek).to eq("bueno")
      expect(stack_queue.peek).to eq(0)
    end

    it "returns nil if the Queue is empty" do
      expect(empty_stack_queue.peek).to eq(nil)
    end
  end

  describe "StackQueue#slinky(private)" do
    it "calls StackQueue#slinky when calling #peek for the first time" do
      expect(stack_queue).to receive(:slinky)
      stack_queue.peek
    end

    it "calles #slinky when calling #dequeue for the first time." do
      expect(stack_queue).to receive(:slinky)
      stack_queue.dequeue

    end
    it "doesn't call #slinky when calling #peek after the first time." do
      stack_queue.peek
      expect(stack_queue).to_not receive(:slinky)
      stack_queue.peek
    end
    it "doesn't call #slinky when calling #dequeue after the first time." do
      stack_queue.dequeue
      expect(stack_queue).to_not receive(:slinky)
      stack_queue.dequeue
    end

  end

  describe "StackQueue#last" do
    it "returns the endmost value" do
      expect(single_stack_queue.last).to eq("bueno")
      expect(stack_queue.last).to eq(2)
    end

    it "returns the correct value after #slinky(private) is called" do
      stack_queue.peek # calls StackQueue#slinky
      expect(stack_queue.last).to eq(2)
      single_stack_queue.peek
      expect(single_stack_queue.last).to eq("bueno")
    end

    it "returns nil if the Queue is empty" do
      expect(empty_stack_queue.last).to eq(nil)
    end
  end

  describe "StackQueue#enqueue" do
    it "insert the value to the end of the Queue" do
      stack_queue.enqueue(6)
      expect(stack_queue.last).to eq(6)
      expect(stack_queue.length).to eq(6)
    end

    it "insert the value to an empty Queue" do
      empty_stack_queue.enqueue("wow")
      expect(empty_stack_queue.last).to eq("wow")
      expect(empty_stack_queue.length).to eq(1)
    end
  end

  describe "StackQueue#dequeue" do
    it "removes the value from the beginning of the Queue" do
      stack_queue.dequeue
      expect(stack_queue.length).to eq(4)
    end

    it "returns the removed value" do
      first = stack_queue.peek
      removed = stack_queue.dequeue
      expect(removed).to be(first)
    end
    it "returns nil if the Queue is empty" do
      expect(empty_stack_queue.dequeue).to eq(nil)
    end

  end


  describe "#min" do
    it "returns the minimum value of the Queue" do
      expect(stack_queue.min).to eq(0)
    end

    it "updates as element is dequeue'ed" do
      stack_queue.dequeue
      expect(stack_queue.min).to eq(2)
    end
  end

  describe "#max" do
    it "returns the maximum value of the Queue" do
      expect(stack_queue.max).to eq(36)
    end

    it "updates as element is dequeue'ed" do
      stack_queue.dequeue
      stack_queue.dequeue

      expect(stack_queue.max).to eq(27)
    end

  end

  describe "::new_with_matadata" do
    let(:custom_stack_queue){
      StackQueue.new_with_metadata(:string_length) { |str| str.length }
    }
    before(:each) {
      ["ecstatic", "sad", "happy", "good"].each { |word| custom_stack_queue.enqueue(word) }
    }

    it "creates a custom matadata that tracks min/max value of the StackQueue." do
      expect(custom_stack_queue.string_length_max).to eq("ecstatic")
      expect(custom_stack_queue.string_length_min).to eq("sad")
    end

    it "updates custom min/max values as elements dequeue" do
      custom_stack_queue.dequeue
      expect(custom_stack_queue.string_length_max).to eq("happy")
      custom_stack_queue.dequeue
      expect(custom_stack_queue.string_length_min).to eq("good")
    end

    it "raise error if the metadata method is called upon an instance whose custom metadata is not set" do
      expect{stack_queue.string_length_max}.to raise_error("such metadata has not been set for this instance")
    end
  end

  describe 'StackQueue#each' do
    it "takes a block and yeilds the block for every element in the StackQueue" do
      array = []
      stack_queue.each {|value| array << value }
      expect(array).to eq([0, 36, 25, 27, 2])
    end
  end


end
