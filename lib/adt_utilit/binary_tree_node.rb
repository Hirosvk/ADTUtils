require_relative "graph_node"

class BinaryTreeNode < GraphNode
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
    if node.children.include?(self)
      raise "Undirected edges are not allowed in binary tree"
    end
    super(node)
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
end
