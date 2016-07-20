class LinkedListNode
  attr_accessor :value, :next, :prev

  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end

  def connect(node)
    self.next = node
    node.prev = self unless node.nil?
  end

  def remove
    if @prev.nil?
      @next.prev = nil
    else
      @prev.connect(@next)
    end
    self
  end

end
