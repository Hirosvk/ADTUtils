require_relative "binary_tree_node"

class BinaryTree
  attr_reader :root
  def initialize(value)
    if value.is_a?(BinaryTreeNode)
      @root = value
      @last = get_last
    else
      @root = BinaryTreeNode.new(value)
    end
  end


  def get_last
    current_node = @root
    while true
      return current_node if current_node.left_child.nil?
      current_node = current_node.left_child
    end
  end

end
