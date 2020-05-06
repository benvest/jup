struct LinkedList{T}
  value::T
  next::Union{LinkedList{T}, Nothing}
end

function add_node(value::T, list::LinkedList{T})

end
