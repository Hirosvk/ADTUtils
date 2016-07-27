# BinaryTreeNode
AdtUtilit's BinaryTreeNode inherits from [GraphNode][graph_node], and has all the same functionality. See below for additional functions.
[graph_node]:graph_node.md

## #connect
BinaryTreeNode#connect method works the same as GraphNode#connect, but only accepts upto two children. It also does not allow undirected edges, and it will raise error.

## #lefth_child/#rigth_child
BinaryTreeNode#left_child returns the first of its children.
```ruby
  tree_node_1 = BinaryTreeNode.new(1)
  tree_node_2 = BinaryTreeNode.new(2)
  tree_node_3 = BinaryTreeNode.new(3)

  tree_node_1.connect(tree_node_2)
  tree_node_1.connect(tree_node_3)

  tree_node_1.left_child # => tree_node_2
  tree_node_2.right_child # => tree_node_3

  # When left_child is removed, the right_child becomes the left_child.
  # This is because 'children' instance variable is an array, and left_child
  # refers to the first element of the array.
  tree_node_1.remove(tree_node_1)
  tree_node_1.left_child # => tree_node_3
```

## Depth First Search methods
BinaryTreeNode offers several Depth First Search that search the tree in different order: In-order Travesal(trav_in_order), Pre-order Traversal(#trav_pre_order), and Post-order Traversal(trav_post_order).
