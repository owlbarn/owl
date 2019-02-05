## The naming scheme

- The one or more output nodes' names are all put in the node collection that is named "result".

- Each node has a unique name.


## Other rules

- If tensor_shape = `[||]`, then it will be printed out as "unknown_rank".
- If an owlnode returns multiple tfnodes, the output node that others should connect to is put in the first element of the returned array.
