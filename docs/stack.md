# Stack
AdtUtilit's Stack is a min/max stack and tracks the current maximum and minimum values of the stack. It also allows users to create their own min/max condition, such as length of the string or a certain property of custom class instances.

All methods run in O(1) time complexity.

To use Stack, add the following line in your ruby file.
```ruby
require 'adt_utilit/stack'
```

## #initialize
When initialized with no argument, the stack is empty.
```ruby
  empty_stack = Stack.new
  empty_stack.length # => 0
```

When initialized with a single object, the stack has that one element.
```ruby
  stack = Stack.new("yay")
  stack.length # => 1
  stack.peek # => "yay"
```

When initialized with an array, the stack contains all elements in the array with the last element on top.
```ruby
  stack = Stack.new(["happy", "sad", "good", "ecstatic"])
  stack.length # => 4
  stack.peek # => "ecstatic"
```

## #push/#pop
Stack#push adds element to the top of the Stack, while Stack#pop removes the topmost element and returns the value.

## #peek
Stack#peek returns the top value of the stack.

## #min/#max
Stack#min and #max returns the current maximum and minimum value of the stack. Since each element in the Stack is kept as a Hash with its value and current max/min, fetching of max/min is don in constant time.

```ruby
    stack = Stack.new([1,34,21,64,0])
    stack.min # => 0
    stack.max # => 64

    stack.pop # => 0
    stack.min # => 1
    stack.max # => 64

    stack.pop # => 64
    stack.max # => 34
```

When #push, the comparison is made with the new value and the current min/max values of the stack using <= and >=.

## ::new_with_metadata
Stack::new_with_metadata is a factory method that returns a new empty Stack capable of tracking additional custom metadata. The method takes the name of the metadata and a block.

```ruby
  stack = Stack.new_with_metadata(:string_length) { |str| str.length }
  # empty Stack is created.

  ["happy", "sad", "good", "ecstatic"].each { |word| stack.push(word) }

  stack.string_length_max # => "ecstatic"
  stack.string_length_min # => "sad"

  stack.push("confused")
  stack.string_length_max # => "confused"
  # when the lengths are equal, the newer value becomes the maximum
```
The current implementation supports only one set of custom metadata.
