require_relative "binary_tree"

class MinHeap < BinaryTree
  def get_min
    @root.value
  end

  def insert(node)
    current_last = @last
    added_node = super(node)
    up_heap(current_last, added_node)
  end

  private
  def up_heap(parant, child)
    if parent == @root
      return
    elsif parent.value < child.value
      return
    else
      parent.switch(child)

    end
  end

end
