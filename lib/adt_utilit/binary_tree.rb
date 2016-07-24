require_relative "binary_tree_node"

class BinaryTree
  attr_reader :root, :last
  def initialize(value)
    if value.is_a?(BinaryTreeNode)
      @root = value
    else
      @root = BinaryTreeNode.new(value)
    end
    @last = get_last
  end


  def insert_to_last(node)
    @last.connect(node)
    get_last
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
  def get_last
    result = @root._bfs {|node| node.left_child && node.right_child.nil?}
    if result.nil?
      result = @root._bfs{ |node| !node.filled? }
    end
    @last = result
  end


end
