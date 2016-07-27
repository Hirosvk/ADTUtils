# GraphNode

## #initialize
It initializes with a value.
```ruby
  graph_node = GraphNode.new(1)
  graph_node.value # => 1
  graph_node.children # => []
```

## #connect
It creates directed link from the receiver to the argument node.
```ruby
  graph_node_1 = GraphNode.new(1)
  graph_node_2 = GraphNode.new(2)

  graph_node_1.connect(graph_node_2)
  graph_node_1.children # => [graph_node_2]
```
It creates undirected link by connecting each other.
```ruby
graph_node_1 = GraphNode.new(1)
graph_node_2 = GraphNode.new(2)

graph_node_1.connect(graph_node_2)
graph_node_2.connect(graph_node_1)
```



## #remove
It removes the node from the receiver's children.
```ruby
graph_node_1 = GraphNode.new(1)
graph_node_2 = GraphNode.new(2)

graph_node_1.connect(graph_node_2)
graph_node_1.children # => [graph_node_2]

graph_node_1.remove(graph_node_2) # => returns graph_node_2
graph_node_1.children # => [graph_node_2]
```

It returns nil when the node is not the receiver's child.
```ruby
graph_node_1 = GraphNode.new(1)
graph_node_2 = GraphNode.new(2)

graph_node_2.remove(graph_node_1) # => nil

```

## #bfs(Breadth First Search)
It searches the graph from the receiver node, and returns the found node. When no node is found, it returns nil. It avoid search the same node twice.

## #dfs(Depth First Search)
It searches the graph from the receiver node, and returns the found node. When no node is found, it returns nil. It avoid search the same node twice.
