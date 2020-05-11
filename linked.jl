struct LinkedList{T}
  value::T
  prev::Union{LinkedList{T}, Nothing}
  next::Union{LinkedList{T}, Nothing}
  function LinkedList(value::T)
    new(value, nothing, nothing)
  end
  function LinkedList(value::T, prev::Union{LinkedList{T}, Nothing}, next::Union{LinkedList{T}, Nothing})
    new(value, prev, next)
  end
end

function add_node(root::LinkedList{T}, value::T)
  newnode = LinkedList(value, root)
  root.next = newnode # what if next is already something? then I should shift everything down by one?
  newnode
end
