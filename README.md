# AdtUtilit (in development)

AdtUtilit is a Ruby gem that provides a set of useful data type classes such as Linked List, Queue, Stack, StackQueue, and Polytree. Many intuitive methods are available for each class. See documentations for the details. [Link to RubyGems][ruby_gems_link]
[ruby_gems_link]:https://rubygems.org/gems/adt_utilit


## Use
AdtUtilit provides various data types with many practical methods that improve time complexity of the program. For example, StackQueue#min/max returns mininum and maximum values of the Queue content in constant time.

See the Big O table [here][big_o_table] for the detailed analysis.
[big_o_table]:docs/methods_big_o_table.md

## Metaprogramming
I used metaprogramming to provide useful features for some classes. For example, Stack class tracks maximum and minimum value in the stack though metadata, and it also lets you create your own metadata. This is useful when you have a stack of strings and want to track the longest and shortest length, or when you have a stack of custom class instances and need to know the maximum and minimum value of a certain property.


## Test-Driven Development
I employed TDD approach in developing AdtUtilit, created a thorough spec using RSpec before writing any code, and conducted unit testing for each class. This ensured the efficiency of the development and resulted in robust and clean code.


## Get Started
After installing the gem(type 'gem install adt_utilit' in the terminal), require necessary ADT library in your file.

```ruby
require 'adt_utilit/linked_list'
```

This gives a access to all the libraries available in the gem.
```ruby
require 'adt_utilit'
```


## Documentation

* [LinkedList][linked_list]
* [Stack][stack]
* [Queue][queue]
* [StackQueue][stack_queue]
* [GraphNode][graph_node]

(in development)
* Graph
* PloyTree
* BinaryTree
* LRUCache
* Ring Buffer

[linked_list]:docs/linked_list.md
[stack]:docs/stack.md
[queue]:docs/queue.md
[stack_queue]:docs/stack_queue.md
[graph_node]:docs/graph_node.md
