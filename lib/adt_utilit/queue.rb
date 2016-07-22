class Queue
  def initialize(value = nil)
    if value.nil?
      @queue = []
    elsif value.is_a?(Array)
      @queue = value
    else
      @queue = [value]
    end
  end

  def length
    @queue.length
  end

  def enqueue(value)
    @queue.push(value)
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue.first
  end

  def last
    @queue.last
  end

end
