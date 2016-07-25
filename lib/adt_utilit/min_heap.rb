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
  def up_heap(parent_node, child_node)
    if parent_node.value < child_node.value
      return
    else
      parent_node.switch(child_node)
      if child_node.parent.nil?
        @root = child_node
        return
      else
        up_heap(child_node.parent, child_node)
      end
    end
  end

end
