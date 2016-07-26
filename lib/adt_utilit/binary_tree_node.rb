require_relative "graph_node"
require 'byebug'

class BinaryTreeNode < GraphNode
  attr_reader :parent

  protected
  attr_writer :parent

  public
  def initialize(value)
    super(value)
  end

  def left_child
    @children[0]
  end

  def right_child
    @children[1]
  end

  def connect(node)
    if @children.length >= 2
      raise "BinaryTreeNode can have only two children"
    end
    # if node.children.include?(self)
    #   debugger
    #   raise "Undirected edges are not allowed in binary tree"
    # end
    super(node)
    node.parent = self
  end

  def switch(node)
    unless self.children.include?(node)
      raise "No parent-child relationship exists"
    end
    replace_idx = self.children.find_index(node)
    self.children, node.children = node.children, self.children
    node.children[replace_idx] = self

    if self.parent.nil?
      node.parent = nil
    else
      replace_idx = self.parent.children.find_index(self)
      self.parent, node.parent = node, self.parent
      node.parent.children[replace_idx] = node
    end
    node.children.each{|child| child.parent = node}
    # debugger
  end

  def filled?
    !!(left_child && right_child)
  end

  def trav_in_order(search_value = nil, &prc)
    if (search_value.nil? && !block_given?) || (search_value && block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    result = left_child ? left_child.trav_in_order(nil, &prc) : nil
    return result unless result.nil?

    result = prc.call(self.value) ? self : nil
    return result unless result.nil?

    result = right_child ? right_child.trav_in_order(nil, &prc) : nil
    return result unless result.nil?

    nil
  end

  def trav_pre_order(search_value = nil, &prc)
    if (search_value.nil? && !block_given?) || (search_value && block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    result = prc.call(self.value) ? self : nil
    return result unless result.nil?

    result = left_child ? left_child.trav_pre_order(nil, &prc) : nil
    return result unless result.nil?

    result = right_child ? right_child.trav_pre_order(nil, &prc) : nil
    return result unless result.nil?

    nil
  end

  def trav_post_order(search_value = nil, &prc)
    if (search_value.nil? && !block_given?) || (search_value && block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    result = left_child ? left_child.trav_post_order(nil, &prc) : nil
    return result unless result.nil?

    result = right_child ? right_child.trav_post_order(nil, &prc) : nil
    return result unless result.nil?

    result = prc.call(self.value) ? self : nil
    return result unless result.nil?
    nil
  end

  def _trav_right_first(search_value = nil, &prc)
    if (search_value.nil? && !block_given?) || (search_value && block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    result = right_child ? right_child._trav_right_first(nil, &prc) : nil
    return result unless result.nil?

    result = left_child ? left_child._trav_right_first(nil, &prc) : nil
    return result unless result.nil?

    result = prc.call(self) ? self : nil
    return result unless result.nil?
    nil
  end
end
