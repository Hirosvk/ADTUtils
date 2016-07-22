require_relative 'linked_list_node.rb'
require "byebug"
class LinkedList
  include Enumerable
  attr_reader :length, :head, :tail

  def initialize(value = nil)
    if value.nil?
      nodes = []
    elsif value.is_a?(Array)
      nodes = initialize_with_array(value)
    elsif value.is_a?(Hash)
      nodes = initialize_with_hash(value)
    else
      nodes = [LinkedListNode.new(value)]
    end
    @head = nodes[0]
    @tail = nodes[-1]
    @length = nodes.length
  end

  def each(&block)
    i = 0
    current_node = @head
    while i < self.length
      block.call(current_node)
      current_node = current_node.next
      i += 1
    end
  end

  def [](idx)
    if (idx >= 0)
      current_node = @head
      self.each_with_index do |node, llidx|
        return node if idx == llidx
        current_node = current_node.next
      end
    else
      current_node = @tail
      i = 0
      while i < @length
        return current_node if idx == -i - 1
        current_node = current_node.prev
        i += 1
      end
    end
    nil
  end

  def push(value)
    if value.is_a?(LinkedListNode)
      node = value
    else
      node = LinkedListNode.new(value)
    end

    if @length == 0
      @head = @tail = node
    else
      @tail.connect(node)
      @tail = node
    end

    @length +=1
    self
  end

  def unshift(value)
    if value.is_a?(LinkedListNode)
      node = value
    else
      node = LinkedListNode.new(value)
    end

    if @length == 0
      @head = @tail = node
    else
      node.connect(@head)
      @head = node
    end
    
    @length +=1
    self
  end

  def pop
    popped_node = @tail.remove
    @length -= 1
    @tail = @tail.prev
    popped_node
  end

  def shift
    shifted_node = @head.remove
    @length -= 1
    @head = @head.next
    shifted_node
  end

  def find(value)
    self.each do |node|
      return node if node.value == value
    end
    nil
  end

  def find_all(value)
    self.select{|node| node.value == value}
  end

  def insert(value, idx)
    if value.is_a?(LinkedListNode)
      node = value
    else
      node = LinkedListNode.new(value)
    end

    node.connect(self[idx])
    self[idx-1].connect(node) if idx > 0
    @head = node if idx == 0 || idx == -@length
    @tail = node if idx == -1 || idx == @length - 1
    @length += 1
  end

  def remove_at(idx)
    removing_node = self[idx]
    return nil if removing_node.nil?

    removing_node.remove
    @tail = removing_node.prev if idx == -1 || idx == @length-1
    @head = removing_node.next if idx == 0 || idx == -@length
    @length -= 1
    idx
  end

  def remove_all(value)
    found = false
    current_node = @head
    while current_node
      if current_node.value == value
        current_node.remove
        @length -= 1
        @head = current_node.next if current_node == @head
        @tail = current_node.prev if current_node == @tail
        found = true
      end
      current_node = current_node.next
    end
    found
  end


  private
  def initialize_with_array(array)
    nodes = []
    array.map.with_index do |el, idx|
      node = LinkedListNode.new(el)
      nodes[-1].connect(node) unless nodes[-1].nil?
      nodes << node
    end
    nodes
  end

  def initialize_with_hash(hash)
    nodes = []
    hash.map do |key, value|
      node = LinkedListNode.new({key => value})
      nodes[-1].connect(node) unless nodes[-1].nil?
      nodes << node
    end
    nodes
  end

end
