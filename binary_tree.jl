using Printf

# TODO: Remove parent attribute
# TODO: Insert method
# TODO: BST
# TODO: Generalize as a graph?

# A binary tree node
mutable struct Node
  value::Int
  parent::Union{Node, Nothing}
  left::Union{Node, Nothing}
  right::Union{Node, Nothing}
  function Node(value)
    new(value, nothing, nothing, nothing)
  end
  function Node(value, parent::Node)
    new(value, parent, nothing, nothing)
  end
  function Node(value, parent::Node, left::Node, right::Node)
    new(value, parent, left, right)
  end
end

# Automatically figure out where to put the next node so that the tree gets filled up symetrically.
#
# 1) Find the first node that has an empty left or right, by performing a breadth first search(?)
# 2) Add the node to the first missing left or right, so traversal is most important
function insert(root::Node, node::Node)
end

# The size of the tree is the total number of nodes
function size(node::Union{Node, Nothing})
  node == nothing ? 0 : 1 + size(node.left) + size(node.right)
end

# Maximum depth of any leaf
function maxdepth(node::Union{Node, Nothing})
  node == nothing ? 0 : 1 + max(maxdepth(node.left), maxdepth(node.right))
end

# Depth of the node, i.e. the number of nodes in between the root node and the given node
function depth(node::Union{Node, Nothing})
  node == nothing && return 0
  isroot(node) ? 1 : 1 + depth(node.parent)
end

# Both children in an array, not sure if this is the most useful thing, but meh
function children(node::Node)
  [ node.left node.right ]
end

# Checks if node is root by seeing if the parent is nothing
function isroot(node::Node)
  node.parent == nothing
end

function isleftchild(node::Node)
  node.parent.left == node
end

function isrightchild(node::Node)
  node.parent.right == node
end

function isleaf(node::Node)
  node.left == nothing && node.right == nothing
end

# the adjacent node
function sibling(node::Node)
  if isleftchild(node)
    node.parent.right
  elseif isrightchild(node)
    node.parent.left
  end
end

# Find all nodes at a given depth from the root node
function find_nodes(root::Node, atdepth)
  nodes = []
  if isleaf(root)
    return nodes
  end
  traverse(root, node -> node != nothing && depth(node) == atdepth && push!(nodes, node))
  nodes
end

# style=[preorder postorder inorder]
function traverse(node::Union{Node, Nothing}, f, style="preorder")
  if node == nothing
    return
  end
  if style == "preorder"
    f(node)
    traverse(node.left, f, style)
    traverse(node.right, f, style)
  elseif style == "postorder"
    traverse(node.left, f, style)
    traverse(node.right, f, style)
    f(node)
  elseif style == "inorder"
    traverse(node.left, f, style)
    f(node)
    traverse(node.right, f, style)
  end
end

# style=[preorder postorder inorder]
function print(node::Union{Node, Nothing}, style="preorder")
  traverse(node, node -> @printf("%d ", node.value))
end

# print all the root-to-leaf paths
function printpaths(node::Node)
  function climb(node)
    if !isleaf(node)
      return
    end
    val = []
    current = node
    push!(val, current.value)
    while true
      current = current.parent
      push!(val, current.value)
      if isroot(current)
        break
      end
    end
    println(reverse(val))
  end
  traverse(node, climb)
end

function findmaxpathsum(node::Node)
  maxsum = 0
  function climb(node)
    if !isleaf(node)
      return
    end
    val = []
    current = node
    push!(val, current.value)
    while true
      current = current.parent
      push!(val, current.value)
      if isroot(current)
        break
      end
    end
    sum = reduce(+, val)
    if sum > maxsum
      maxsum = sum
    end
  end
  traverse(node, climb)
  maxsum
end
