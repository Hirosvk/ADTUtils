# LinkedList

## ::initialize
When it initializes with a single value or object, it creates a LinkedList with the first(and last) LinkedListNode whose value is the value
```ruby
  new_list = LinkedList.new("happy")
  new_list[0].value # => "happy"
  new_list.length # => 1

```

When it initializes with an array, it creates a LinkedListNode for each element.

```ruby
  array_list = LinkedList.new(["happy", "sad", "sleepy", "energetic"])
  array_list.length # => 2
  array_list[0].value # => "happy"
  array_list[1].value # => "sad"
```

When it initializes with a hash, each LinkedListNode has one key-value pair.
```ruby
  hash_list = LinkedList.new({feliz: "happy", triste: "sad"})
  hash_list.length # => 2
  hash_list[0].value # => {feliz: "happy"}
  hash_list[1].value # => {triste: "sad"}
```

## Enumerable
Ruby's Enumerable module methods are supported, such as each, map, and select.

## Accessing LinkedListNode or its value
```ruby
  linked_list = LinkedList.new(["happy", "sad", "sleepy", "energetic"])

  linked_list.length # => 2
  linked_list.head # => LinkedListNode with the value "happy"
  linked_list.head.next # => LinkedListNode with value "sad"
  linked_list.tail # => LinkedListNode with the value "energetic"
  linked_list.tail.prev # => LinkedListNode with value "sleepy"

  linked_list[0].value # => "happy"
  linked_list[-1].value # => "energetic"
  linked_list[-2].value # => "sleepy"
```


## Adding / Removing Nodes
LinkedList#push and LinkedList#unshift takes either a LinkedListNode or a value. When a value is given as an argument, the method creates a new LinkedListNode.
```ruby
  linked_list = LinkedList.new(["happy", "sad"])
  node = LinkedListNode.new("good")
  linked_list.push(node)
  linked_list.map(&:value) # => ["happy, "sad", "good"]

  linked_list.unshift("nice")
  linked_list.map(&:value) # => ["nice", "happy, "sad", "good"]
```

LinkedList#pop and LinkedList#shift returns the removed node.
