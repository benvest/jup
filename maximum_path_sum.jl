# Euler problem 18 and 67
#
# I learned a lot on this one, since my first approach was whoefully inadiquate. My initial reaction was to
# stick the data into a binary tree, since traversal would be fairly natural. The limitation of this approach
# became obvious when I went from problem 18 to the more difficult problem 67, theres even a warning on problem
# 18 but alas.
#
# This is a good demonstration of the power of dynamic programming.

# My initial reaction to this problem was really to do something very similar to this, except I was trying to
# iterate down the tree and take the max node at each point. This never could have worked, and the reason the
# below method does work, is because I am iterating up the tree instead of down it. By moving up we are
# eliminating choices, so that everything converges to one point. The alternative strategy that I was trying
# and have tried to use before for other things and met similar resistance increases the number of choices
# or points of divergence, at each step.

function load_data()
  io = open("p067_triangle.txt", "r");
  data = map(x -> split(x, " "), split(read(io, String), "\n"))
  lines = length(data)-1
  triangle = zeros(lines, lines)
  for (i, line) in enumerate(data)
    for (j, number) in enumerate(line)
      if length(number) > 0
        triangle[i, j] = parse(Int, number)
      end
    end
  end
  triangle
end

function solve()
  triangle = load_data()
  lines = length(triangle[1,:]) # shouldnt there be a way to get the length without calling the index?
  largest = triangle[lines, :]

  for i = lines-1:-1:1
    for j = 1:1:i
      largest[j] = triangle[i, j] + max(largest[j], largest[j+1])
    end
  end

  first(largest)
end
