using Printf
# Things I still need to figure out:
# * Loading the data into the tree
# * The rest of the not finished functions, so a way to sum paths
# * Heuristics to reduce the number of paths that need to be searched
#     This will probably involve something to do with certain paths which can be eliminated before fully
#     traversing the path. An initial guess at a way to find this would be to compare different paths to
#     see if there is some general trend. That is if one can tell with any amount of certainty whether the
#     sum of, say half, of the path reveals enough to not compute the other half.
# * Better pretty printing
# * Generalize to allow for arbitrary values
# * Generalize to be a binary search tree using an internal index?? (why though, is there any advantage?)
function loaddata()
  data = [
    [75],
    [95 64],
    [17 47 82],
    [18 35 87 10],
    [20 04 82 47 65],
    [19 01 23 75 03 34],
    [88 02 77 73 07 63 67],
    [99 65 04 28 06 16 70 92],
    [41 41 26 56 83 40 80 70 33],
    [41 48 72 33 47 32 37 16 94 29],
    [53 71 44 65 25 43 91 52 97 51 14],
    [70 11 33 28 77 73 17 78 39 68 17 57],
    [91 71 52 38 17 14 91 43 58 50 27 29 48],
    [63 66 04 68 89 53 67 30 73 16 69 87 40 31],
    [04 62 98 27 23 09 70 98 73 93 38 53 60 04 23]
  ]

  function partition(row)
    parts = []
    for i = 1:length(row)-1
      push!(parts, [row[i] row[i+1]])
      # if i > 1 && i < length(row)-1
      #   push!(parts, [row[i] row[i+1]])
      # end
    end
    parts
  end

  root = nothing

  for (i, row) in enumerate(data)
    if i == 1
      root = Node(first(row))
      continue
    end

    if i == 2
      root.left = Node(row[1], root)
      root.right = Node(row[2], root)
      continue
    end

    prev = find_nodes(root, i-1)
    # println(length(prev))
    parts = partition(row)
    # println(length(parts))
    # println(parts)
    for (j, node) in enumerate(prev)
      # println(j)
      # println(node.value)
      if j > 2
        println(j)
        println(length(prev)%j)
        println(max(1, (j-1) - length(prev)%j))
        part = parts[max(1, (j-1) - length(prev)%j)]
        node.left = Node(first(part), node)
        node.right = Node(last(part), node)
      else
        part = parts[j]
        node.left = Node(first(part), node)
        node.right = Node(last(part), node)
      end
      print(root)
    end
  end

  root
end
# generate a small test tree
function generatetree()
  root = Node(1)
  n2 = Node(2, root)
  n3 = Node(3, root)
  root.left = n2
  root.right = n3

  n4 = Node(4, n2)
  n5 = Node(5, n2)
  n2.left = n4
  n2.right = n5

  n55 = Node(5, n3)
  n6 = Node(6, n3)
  n3.left = n55
  n3.right = n6

  n7 = Node(7, n4)
  n8 = Node(8, n4)
  n4.left = n7
  n4.right = n8

  n88 = Node(8, n5)
  n9 = Node(9, n5)
  n5.left = n8
  n5.right = n9

  n888 = Node(8, n55)
  n99 = Node(9, n55)
  n55.left = n888
  n55.right = n99

  n999 = Node(9, n6)
  n10 = Node(10, n6)
  n6.left = n999
  n6.right = n10

  root
end

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
  println(root)
  if isleaf(root)
    return nodes
  end
  traverse(root, node -> node != nothing && depth(node) == atdepth && push!(nodes, node))
  nodes
end

# This will do a depth first search, so I just had an idea for the summation of the triangle. It may be possible
# to only touch each node once and still find the maximum path sum. We will store two pieces of information in some
# way. 1) the total path sum up to the current node 2) something about depth maybe?... whatever we store the point
# is that by comparing the current sum we will always have the highest value until some (valid) path is traversed
# that has a greater value. The path will always be valid because the tree is constructed to be a complete tree,
# so idk, its 3:09, but if this works it could be pretty damn cool.

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

# these should probably use a generic traversal method, or put another way this is a special type of
# traveral (preorder) but also printing is just a special case of the general case of traversing the tree.
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

# find all possible root-to-leaf sums
# this is the thing that the tree is really being used for, with all the rest of this stuff just a good
# learning experience / something to build with julia. but the real task is to find the greatest sum of all
# the path sums, which requires slightly more than just having a tree, but the tree structure and all of the
# helper methods that surround it (parent, siblings, children, etc) should help me find a working solution.
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

# Automatically figure out where to put the next node so that the tree gets filled up symetrically.
#
# 1) Find the first node that has an empty left or right, by performing a breadth first search(?)
# 2) Add the node to the first missing left or right, so traversal is most important
function insert(root::Node, node::Node)
end
