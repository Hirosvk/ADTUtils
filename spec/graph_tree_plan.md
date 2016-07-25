GraphNode
@children
*use adjacency list in array*
#bfs
#dfs
#connect
#remove


BinaryTreeNode < GraphNode
@left_child
@rigth_child
@value
#trav_in_order
#trav_pre_order
#trav_out_order
#bfs *< GraphNode*

#filled?

BinaryTree
initialize with root node or a value
@root *= BinaryTreeNode instance*
#trav_in_order
#trav_pre_order
#trav_out_order
#bfs

#root
#last
#get_last
#insert_to_last
#full?
#perfect?
#complete?

MinHeap < BinaryTree
initialize with root node or a value
#get_min
#insert -> #fix
#remove_min -> #fix

MaxHeap < BinaryTree
initialize with root node or a value
#get_max
#insert -> #fix
#remove_max -> #fix

CustomHeap < BinaryTree
