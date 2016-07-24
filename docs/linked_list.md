# LinkedListNode
AdtUtilit's LinkedListNode is a doubly-linked list node, and the node's adjacent nodes are accessible by #next and #prev functions. You can get the value of the node by calling #value.

To use LinkedListNode, include this line in your file.
```ruby
  require 'adt_utilit/linked_list_node'
```

## #connect/#remove
LinkedListNode#connect and #remove take care of the prev/next relationships.
```ruby
  node1 = LinkedListNode.new("a")
  node2 = LinkedListNode.new("b")
  node3 = LinkedListNode.new("c")

  node1.connect(node2)
  node1.next # => node2
  node2.prev # => node1

  node2.connect(node3)
  node2.remove
  node1.next # => node3
  node3.prev # => node1
```


# LinkedList
LinkedList is a collection of LinkedListNodes, and provides practical methods to work with linked list.

```ruby
require 'adt_utilit/linked_list'
```

## #initialize
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


## Accessing LinkedListNode and its value
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

LinkedList#insert lets you add a LinkedListNode or value in the middle of LinkedList and shifts the subsequent LinkedListNode.

```ruby
  linked_list = LinkedList.new(["happy", "sad", "sleepy", "energetic"])
  node = LinkedListNode.new("good")
  linked_list.insert(node, 1)
  linked_list.map(&:value) # => ["happy, "good", "sad", "good"]


  linked_list.insert("nice", 2)
  linked_list.map(&:value) # => ["happy", "good", "nice", "sad", "sleepy", "energetic"]
```

LinkedList#remove_at removes the LinkedListNode at the index. It returns nil if no such index exists.
```ruby
  linked_list = LinkedList.new(["happy", "sad", "happy", "energetic"])
  linked_list.remove_at(2)
  linked_list.map(&:value) # => ["happy, "sad", "energetic"]

  linked_list = LinkedList.new(["happy", "sad", "happy", "energetic"])
  linked_list.remove_all("happy")
  linked_list.map(&:value) # => ["sad", "energetic"]

```

## Enumerable
Ruby's Enumerable module methods are supported, such as each, map, and select.


## #find_node/#find_all
LinkedList#find_node takes a value to search in LinkedList, and returns LinkedListNode with the value. If not value is found, it returns nil. Enumerable's #find returns the value while LinkedList#find_node returns a LinkedListNode object.

```ruby
  linked_list = LinkedList.new(["happy", "sad", "happy", "energetic"])
  linked_list.find_node("happy")
  # => returns the first LinkedListNode, whose value is "happy"

  linked_list.find_node("dragon")
  # => returns nil
```

LinkedList#find_all returns all found LinkedListNodes in an array.
```ruby
  linked_list = LinkedList.new(["happy", "sad", "happy", "energetic"])
  linked_list.find_all("happy")
  # => returns an array with two LinkedListNodes, whose values are "happy"

  linked_list.find("dragon")
  # => returns nil
```
