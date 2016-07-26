require_relative "binary_tree_node"

class BinaryTree
  attr_reader :root, :last, :last_parent
  def initialize(value)
    if value.is_a?(BinaryTreeNode)
      @root = value
    else
      @root = BinaryTreeNode.new(value)
    end
    @last_parent = get_last_parent
    @last = get_last_node
  end


  def insert(node)
    node = BinaryTreeNode.new(node) unless node.is_a?(BinaryTreeNode)
    @last_parent.connect(node)
    get_last_parent
    get_last_node
    node
  end


  def bfs(value = nil, &prc)
    @root.bfs(value, &prc)
  end

  def trav_in_order(value = nil, &prc)
    @root.trav_in_order(value, &prc)
  end

  def trav_pre_order(value = nil, &prc)
    @root.trav_pre_order(value, &prc)
  end

  def trav_post_order(value = nil, &prc)
    @root.trav_post_order(value, &prc)
  end

  protected
  def get_last_parent
    result = @root._bfs {|node| node.left_child && node.right_child.nil?}
    if result.nil?
      result = @root._bfs{ |node| !node.filled? }
    end
    @last_parent = result
  end

  def get_last_node
    result = @root._bfs{|node| node.left_child && node.right_child.nil?}
    if result
      @last = result.left_child
    else
      @last = @root._trav_right_first{|node| !node.filled?}
    end
  end

end
