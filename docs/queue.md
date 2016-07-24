# Queue
AdtUtilit's Queue is a basic implementation of Queue, and offers common methods such as enqueue, dequeue, and peek. Ruby's Enumerable methods can also be used such as each, map and select.

To use Stack, add the following line in your ruby file.
```ruby
require 'adt_utilit/queue'
```

## #initialize
When initialized with no argument, the Queue is empty.
```ruby
  empty_queue = Queue.new
  empty_queue.length # => 0
```

When initialized with a single object, the Queue has that one element.
```ruby
  queue = Queue.new("yay")
  queue.length # => 1
  queue.peek # => "yay"
```

When initialized with an array, the Queue contains all elements in the array with the last element on top.
```ruby
  queue = Queue.new(["happy", "sad", "good", "ecstatic"])
  queue.length # => 4
  queue.peek # => "happy"
  queue.last # => "ecstatic"
```

## get values (#peek/#last)
Queue#peek returns the front-most value. Queue#last returns the end-most value.

## enqueue/dequeue
Queue#enqueue adds the value to the end of the Queue.
```ruby
  queue = Queue.new([2,3,6,7,3])
  queue.enqueue(8)
  stack.last # => 8
```

Queue#dequeue removes the first element and return the element.
```ruby
  queue = Queue.new([2,3,6,7,3])
  queue.dequeue # => 2
```
## Enumerable
Ruby's Enumerable module methods are supported, such as each, map, and select.
