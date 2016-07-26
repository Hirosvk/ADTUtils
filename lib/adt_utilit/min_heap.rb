require_relative "binary_tree"

class MinHeap < BinaryTree
  def get_min
    @root.value
  end

  def insert(node)
    current_last = @last_parent
    added_node = super(node)
    up_heap(current_last, added_node)
    get_last_parent
    get_last_node
    # debugger
  end

  def remove_min
    return_value = get_min

    @last.parent.remove(@last)
    @last.send("parent=", nil)
    right = @root.remove(@root.right_child)
    left = @root.remove(@root.left_child)
    @last.connect(left)
    @last.connect(right)

    @root = @last
    down_heap(@root)

    get_last_parent
    get_last_node
    return_value
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

  def down_heap(node)
    if node.children.empty?
      return
    elsif node.left_child &&
      node.value > node.left_child.value &&
      (node.right_child.nil? || node.right_child.value > node.left_child.value)
      @root = node.left_child
      node.switch(node.left_child)
      down_heap(node)
      return
    elsif node.right_child &&
      node.value > node.right_child.value &&
      (node.left_child.nil? || node.left_child.value > node.right_child.value)
      @root = node.right_child
      node.switch(node.right_child)
      down_heap(node)
      return
    end
  end

end
