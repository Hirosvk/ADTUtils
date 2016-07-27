* indexing takes O(n) since LinkedList only has pointers to the head and tail. I had an idea of giving each node an index, but that would increase insertion and removal's time complexity from O(1) to O(n).

* as I coded, I found many holes in my specs. To cover the whole class, the spec would be so long.

* I spend a lot of time creating Heap tree by inheriting from BinaryTree. this was not a good idea because Heap tree require switching of nodes, which involve complex replacement of node's children and parents, and its parents children. Through this process I understood the reasons why Heaps are often implemented using arrays, not BinaryTree.

 
