# StackQueue
AdtUtilit's StackQueue provides exactly the same functionality as Queue, plus the ability to get maxinum and minimum values of the StackQueue content in O(1) time. (This is made possible by storing data in two Stacks inside of Queue.) It also let you define your min/max conditions, such as length of the string or a certain property of custom class instances.

To use Stack, add the following line in your ruby file.
```ruby
require 'adt_utilit/stack_queue'
```

## #initialize
When initialized with no argument, the StackQueue is empty.
```ruby
  empty_stack_queue = StackQueue.new
  empty_stack_queue.length # => 0
```

When initialized with a single object, the StackQueue has that one element.
```ruby
  stack_queue = StackQueue.new("yay")
  stack_queue.length # => 1
  stack_queue.peek # => "yay"
```

When initialized with an array, the StackQueue contains all elements in the array with the last element on top.
```ruby
  stack_queue = StackQueue.new(["happy", "sad", "good", "ecstatic"])
  stack_queue.length # => 4
  stack_queue.peek # => "happy"
  stack_queue.last # => "ecstatic"
```

## get values (#peek/#last)
StackQueue#peek returns the front-most value. StackQueue#last returns the end-most value.

## enqueue/dequeue
StackQueue#enqueue adds the value to the end of the StackQueue.
```ruby
  stack_queue = StackQueue.new([2,3,6,7,3])
  stack_queue.enqueue(8)
  stack.last # => 8
```

StackQueue#dequeue removes the first element and return the element.
```ruby
  stack_queue = StackQueue.new([2,3,6,7,3])
  stack_queue.dequeue # => 2
```

## min/max
```ruby
  stack_queue = StackQueue.new([2,3,6,7,3])
  stack_queue.min # => 2
  stack_queue.max # => 7
```

## setting custom metadata (::new_with_metadata)
StackQueue::new_with_metadata is a factory method that returns a new empty StackQueue capable of tracking custom metadata. The method takes the name of the metadata and a block.

```ruby
  stack_queue = StackQueue.new_with_metadata(:string_length) { |str| str.length }
  # empty StackQueue is created.

  ["happy", "sad", "good", "ecstatic"].each { |word| stack_queue.enqueue(word) }

  stack_queue.string_length_max # => "ecstatic"
  stack_queue.string_length_min # => "sad"

  stack_queue.push("confused")
  stack_queue.string_length_max # => "confused"
  # when the lengths are equal, the newer value becomes the maximum
```
The current implementation supports only one set of custom metadata.

## Enumerable
Ruby's Enumerable module methods are supported, such as each, map, and select.
