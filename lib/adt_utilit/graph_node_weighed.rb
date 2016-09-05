require_relative "graph_node"
require 'set'

class GraphNodeWeighed < GraphNode
  def connect(node, weight)
    raise "invalid weight: needs to be integer" unless weight.is_a?(Integer)
    @children << [node, weight]
  end

  def weight(node)
    target = node.is_a?(self.class) ? node.value : node
    found = @children.find{ |el| el[0].value == target }
    return nil if found.nil?
    found[1]
  end

  # def shortest_paths_to_all_nodes
  #   @path_weight = Hash.new(Array.new)
  #   @path_weight[self.value] = [0, self.value]
  #   @checked_node_values = Set.new
  #
  #   self._shortest_paths_to_all_nodes(self)
  #
  #   path_weight
  # end

  # def _shortest_paths_to_all_nodes(initial_node)
  #   return if self.children.length < 1 || initial_node.checked_node_values.include?(self.value)
  #
  #   initial_node.checked_node_values.add(self.value)
  #   children_queue = self.children.map(&:first).sort{|el1, el2| self.weight(el1) <=> self.weight(el2)}
  #
  #   children_queue.each do |child|
  #     current_path_weight = initial_node.path_weight[child.value][0]
  #     path_weight_to_self = initial_node.path_weight[self.value][0]
  #     new_path_weight = path_weight_to_self + self.weight(child.value)
  #     debugger if current_path_weight && current_path_weight > new_path_weight
  #     if current_path_weight.nil? || (current_path_weight > new_path_weight)
  #       initial_node.path_weight[child.value] = [new_path_weight, self.value]
  #     end
  #     child._shortest_paths_to_all_nodes(initial_node)
  #   end
  # end
  # attr_accessor :path_weight, :checked_node_values


  def shortest_paths_to_all_nodes
    path_weight = Hash.new(Array.new)
    path_weight[self.value] = [0, self.value]
    checked_node_values = Set.new

    checked_node_values.add(self.value)
    children_queue = [[self, self.sort_children]]
    # you need to start with the child whose weight is shortest to 'self'
    # otherwise, it might miss the shortest path when, for example, a certain
    # node has been checked through a longer path, and that node won't be checked
    # again.

    until children_queue.empty?
      current_queue = children_queue.shift
      current_node = current_queue[0]
      checked_node_values.add(current_node.value)
      current_queue = current_queue[1]

      until current_queue.empty?
        child = current_queue.shift
        current_path_weight = path_weight[child.value][0]
        path_weight_to_self = path_weight[current_node.value][0]
        new_path_weight = path_weight_to_self + current_node.weight(child.value)

        if current_path_weight.nil? || (current_path_weight > new_path_weight)
          path_weight[child.value] = [new_path_weight, current_node.value]
        end
        new_children = child.sort_children.reject{|el| checked_node_values.include?(el.value)}
        children_queue << [child, new_children] unless new_children.empty?
      end
    end
    path_weight
  end

  def sort_children
    self.children.map(&:first).sort{|el1, el2| self.weight(el1) <=> self.weight(el2)}
  end

  def shortest_path_to(node)
    target = node.is_a?(self.class) ? node.value : node
    path_weight = shortest_paths_to_all_nodes
    result = []

    unless path_weight[target][1].nil?
      prev_value = target
      while true
        result << prev_value
        prev_value = path_weight[prev_value][1]
        break if prev_value == self.value
      end
      result << self.value
    end
    result.reverse
  end


end
