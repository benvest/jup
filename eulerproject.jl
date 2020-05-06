include("fibonacci.jl")

# By considering the terms in the Fibonacci sequence whose values do not exceed four million,
# find the sum of the even-valued terms.
#
# https://projecteuler.net/problem=2
function p2()
  i = 1
  fibs = []
  while true
    nf = fibonacci(i)
    if nf > 4e6
      break
    end
    push!(fibs, fibonacci(i))
    i += 1
  end
  reduce(+, filter(x -> x % 2 == 0, fibs))
end

# https://projecteuler.net/problem=4
function p4()
  largest = 0
  for i = 100:999
    for j = 100:999
      value = i*j
      if digits(value) == reverse(digits(value)) && value > largest
        largest = value
      end
    end
  end
  largest
end

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
#
# https://projecteuler.net/problem=5
function p5(upto=20)
  function checker(x)
    for i = 1:upto
      if x % i != 0
        return false
      end
    end
    return true
  end
  x = upto
  while true
    if checker(x)
      return x
    else
      x += 1
    end
  end
end

function p6(n=100)
  total_square = 0
  total_sum = 0
  for i = 1:n
    total_square += i^2
    total_sum += i
  end
  total_sum_square = total_sum^2
  total_sum_square - total_square
end

function p8()
  digs = digits(73167176531330624919225119674426574742355349194934969835203127745063262395783180169848018694788518438586156078911294949545950173795833195285320880551112540698747158523863050715693290963295227443043557668966489504452445231617318564030987111217223831136222989342338030813533627661428280644448664523874930358907296290491560440772390713810515859307960866701724271218839987979087922749219016997208880937766572733300105336788122023542180975125454059475224352584907711670556013604839586446706324415722155397536978179778461740649551492908625693219784686224828397224137565705605749026140797296865241453510047482166370484403199890008895243450658541227588666881164271714799244429282308634656748139191231628245861786645835912456652947654568284891288314260769004224219022671055626321111109370544217506941658960408071984038509624554443629812309878799272442849091888458015616609791913387549920052406368991256071760605886116467109405077541002256983155200055935729725716362695618826704282524836008232575304207529634500)
  parts = []
  for i = 1:77
    part = []
    x = max(1, ((i-1)*13))
    for j = 1:13
      push!(part, digs[x+j])
    end
    push!(parts, reduce(*, part))
  end

  largest = 0
  for p in parts
    if p > largest
      largest = p
    end
  end
  
  largest
end


# Given a square that is nxm there are some number of combinations of rows and columns into rectangles.
#
# For example 3x2 can be broken down into 18 different rectangles:
#
# 6 + 3 + 2 + 4 + 2 + 1
function rectangular(n, m)
  # count = 1 + n + m + n*m + max(0, n*m*(n-2)) + max(0, n*m*(m-2))

  total = n*m


  count = 1 + n + m + total

  count
end
# https://projecteuler.net/problem=85


# # whole rectangle counts as a block
# total = 1
# # trivial 1x1 blocks
# total += n*m
# # rows and cols make rectangles
# total += n # n rectangles of length m
# total += m # m rectangles of length n
# # now we need to go column by column finding the combinations
# x = n
# xt = 0
# while x > 2
#   x -= 1
#   xt += x
# end
# total += m*xt
# # last row by row to find combinations
# y = m
# yt = 0
# while y > 2
#   y -= 1
#   yt += y
# end
# total += n*yt
#
# total




# https://projecteuler.net/problem=10
# https://projecteuler.net/problem=6
# https://projecteuler.net/problem=9
