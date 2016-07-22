require "adt_utilit/stack"

describe 'Stack' do
  let(:string_stack) { Stack.new(["happy", "sad", "good", "ecstatic"]) }
  let(:integer_stack) { Stack.new([1,34,21,64,0]) }
  let(:empty_stack){ Stack.new }
  let(:single_stack) { Stack.new("yay") }

  describe "Stack::initialize" do
    it "initializes with no value and creates an empty stack" do
      expect(empty_stack.length).to eq(0)
    end

    it "initializes with one value" do
      expect(single_stack.length).to eq(1)
      expect(single_stack.peek).to eq("yay")
    end

    it "when given an array, the new Stack contains the array elements with the last element on top" do
      expect(string_stack.length).to eq(4)
      expect(string_stack.peek).to eq("ecstatic")
    end
  end

  describe "Stack#push" do
    it "adds value to stack" do
      string_stack.push("blue")
      expect(string_stack.peek).to eq("blue")
      expect(string_stack.length).to eq(5)
    end

    it "adds value to empty stack" do
      empty_stack.push("blue")
      expect(empty_stack.peek).to eq("blue")
      expect(empty_stack.length).to eq(1)
    end
  end

  describe "Stack#pop" do
    it "removes the element from the top" do
      top = string_stack.pop
      expect(string_stack.peek).to eq("good")
      expect(string_stack.length).to eq(3)
      expect(top).to eq("ecstatic")
    end

    it "returns nil if the stack is empty" do
      expect(empty_stack.pop).to eq(nil)
    end

  end

  describe "Stack#peek" do
    it "returns nil if the stack is empty" do
      expect(empty_stack.peek).to eq(nil)
    end
  end

  describe "Stack#min" do
    it "returns the minimum value of the whole stack" do
      expect(integer_stack.min).to eq(0)
    end

    it "updates the minimum value as elements are pushed in/popped out" do
      integer_stack.pop
      expect(integer_stack.min).to eq(1)
      integer_stack.push(-4)
      expect(integer_stack.min).to eq(-4)
    end
  end

  describe "Stack#max" do
    it "returns the maximum value of the whole stack" do
      expect(integer_stack.max).to eq(64)
    end

    it "updates the maximum value as elements are pushed in/popped out" do
      integer_stack.pop
      expect(integer_stack.max).to eq(64)
      integer_stack.pop
      expect(integer_stack.max).to eq(34)
      integer_stack.push(100)
      expect(integer_stack.max).to eq(100)
    end
  end

  describe "Stack#new_with_matadata" do
    it "creates a custom matadata that tracks min/max value of the stack." do
      stack = Stack.new_with_metadata(:string_length) { |str| str.length }
      ["happy", "sad", "good", "ecstatic"].each { |word| stack.push(word) }

      expect(stack.string_length_max).to eq("ecstatic")
      expect(stack.string_length_min).to eq("sad")
    end
  end

end
