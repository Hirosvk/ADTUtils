# AdtUtilit (in development)

AdtUtilit is a Ruby gem that provides a set of useful data type classes such as Linked List, Queue, Stack, StackQueue, and Polytree. Most common and intuitive methods are available for each class. See documentations for the details. [Link to RubyGems][ruby_gems_link]
[ruby_gems_link]:https://rubygems.org/gems/adt_utilit

## Get Started
After installing the gem(type 'gem install adt_utilit' in the terminal), require necessary ADT library in your file.

```ruby
require 'adt_utilit/linked_list'
```

The below gives a access to all the libraries available in the gem.
```ruby
require 'adt_utilit/'
```

## Test-Driven Development
I employed TDD approach in developing AdtUtilit, created a thorough spec using RSpec before writing any code, and conducted unit testing for each class. This ensured the efficiency of the development and resulted in robust and clean code.

## Metaprogramming
I used some metaprogramming to provide useful features. For example, Stack class tracks maximum and minimum value in the stack though metadata, and it also lets you create your own metadata. This is useful when you have a stack of strings and want to track the longest and shortest length, or when you have a stack of custom class instances and need to know the maximum and minimum value of a certain property.

## Documentation

* [LinkedList][linked_list]

(in development)
* Stack
* Queue
* StackQueue
* Graph
* PloyTree
* BinaryTree
* LRUCache
* Ring Buffer

[linked_list]:docs/linked_list.md

## Time Complexity Analysis
Many of ADT implementation in AdtUtilit are optimized for time complexity and takes larger memory availability.
See the Big O table [here][big_o_table].
[big_o_table]:docs/methods_big_o_table.md
