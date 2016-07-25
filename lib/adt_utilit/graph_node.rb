require 'set'
require 'byebug'
class GraphNode
  attr_reader :children, :value

  protected
  attr_writer :children

  public
  def initialize(value)
    @value = value
    @children = []
  end

  def connect(node)
    @children << node
  end

  def remove(node)
    result = @children.delete(node){nil}
    result.nil? ? nil : node
  end

  def remove_all
    @children = []
  end

  def dfs(search_value = nil, searched = Set.new, &prc)
    if (search_value && block_given?) || (search_value.nil? && !block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    if prc.call(self.value)
      return self
    else
      searched.add(self)
    end

    return nil if @children.empty?

    @children.each do |child_node|
      return nil if searched.include?(child_node)
      result = child_node.dfs(nil, searched, &prc)
      return result if !result.nil?
      searched.add(child_node)
    end
    return nil
  end

  def bfs(search_value = nil, searched = Set.new, &prc)
    if (search_value && block_given?) || (search_value.nil? && !block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    search_queue = [self]
    until search_queue.empty?
      node = search_queue.shift
      return node if prc.call(node.value)
      searched.add(node)

      if node.children.length > 0
        node.children.each do |child|
          search_queue << child unless searched.include?(child)
        end
      end
    end
    return nil

  end

  def _bfs(search_value = nil, searched = Set.new, &prc)
    if (search_value && block_given?) || (search_value.nil? && !block_given?)
      raise "Wrong number of argument"
    end
    prc = Proc.new{ |val| val == search_value } if search_value

    search_queue = [self]
    until search_queue.empty?
      node = search_queue.shift
      return node if prc.call(node)
      searched.add(node)

      if node.children.length > 0
        node.children.each do |child|
          search_queue << child unless searched.include?(child)
        end
      end
    end
    return nil

  end


end
