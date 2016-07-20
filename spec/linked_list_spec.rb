require 'rspec'
require 'linked_list.rb'


describe 'LinkedListItem' do
  subject(:item) {LinkedListItem.new("happy")}
  describe 'LinkedListItem#value' do
    it "returns the value of the instance" do
      expect(item.value).to eq("happy")
    end
  end

  describe 'LinkedLisItemt#next'do
    it "returns a LinkedListItem instance"
    it "the returned instance has the correct value"
  end

  describe 'LinkedListItem#prev' do
    it "returns a LinkedListItem instance"
    it "the returned instance has the correct value"
  end
end


describe 'LinkedList' do
  describe 'LinkedList#head' do
    it 'is nil when '
  end

  describe 'LinkedList#tail' do

  end

  describe 'LinkedList#length'do

  end

  describe 'LinkedList#push' do
    it 'updates the LinkedList::tail'
    it "assigns the new element's 'next' as nil"
    it "assigns the new element's 'prev' as the previous tail"
  end

  describe 'LinkedList#pop' do
    it 'updates the LinkedList::tail'
    it "assigns the second to the last element's next as nil"
  end

  describe 'LinkedList#shift' do

  end

  describe 'LinkedList#unshift' do

  end


  describe 'LinkedList#remove' do

  end

  describe 'LinkedList#insert' do

  end

  describe 'LinkedList#find' do

  end

end
