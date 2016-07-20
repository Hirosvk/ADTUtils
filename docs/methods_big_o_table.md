## Array (Ruby dynamic array)
operation          | methods                 | time complexity
-------------------|-------------------------|-------

push        | O(1)
pop         | O(1)
shift       | O(1)
unshift     | O(n)
[] (index)  | O(1)
find        | O(n)
insert      | O(1)

## LinkedList
operation          | methods                 | time complexity
-------------------|-------------------------|-------
adding             | push, shift             | O(1)
removing           | pop, unshift            | O(1)
find               | find                    | O(n)
indexing           | []/remove_at/insert     | O(n)

* LinkedListNodes are not indexed, so #[n] finds nth Node through iteration.
