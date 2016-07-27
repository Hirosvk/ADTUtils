require 'byebug'
class MinHeap

  def initialize(value = nil)
    @tree = []
    if value.is_a?(Array)
      value.each do |el|
        self.insert(el)
      end
    elsif value
      self.insert(value)
    end
  end

  def length
    @tree.length
  end

  def get_min
    @tree.first
  end

  def insert(value)
    @tree << value
    up_heap(@tree.length - 1)
  end

  def remove_min
    removed = @tree.shift
    last = @tree.pop
    @tree.unshift(last)
    down_heap(0)
    removed
  end

  private
  def up_heap(child_idx)
    return if child_idx == 0
    parent_idx = (child_idx - 1) / 2
    if @tree[parent_idx] > @tree[child_idx]
      @tree[parent_idx], @tree[child_idx] = @tree[child_idx], @tree[parent_idx]
      up_heap(parent_idx)
    end
  end

  def down_heap(parent_idx)
    child_idx1 = (parent_idx * 2) + 1
    child_idx2 = (parent_idx * 2) + 2
    if @tree[child_idx1] && @tree[child_idx2]
      child_idx = @tree[child_idx1] > @tree[child_idx2] ? child_idx2 : child_idx1
    else
      child_idx = @tree[child_idx1] ? child_idx1 : child_idx2
      return if @tree[child_idx].nil?
    end
    debugger if @tree[child_idx].nil?
    if @tree[child_idx] < @tree[parent_idx]
      @tree[parent_idx], @tree[child_idx] = @tree[child_idx], @tree[parent_idx]
      down_heap(child_idx)
    end
  end

end
