using Primes
using StatsBase

# Triangular numbers are the result of adding up all the natural numbers from 1:n, each number n represents the sum
# from one to n, so T_1 = 1, T_2 = 1 + 2 = 3, T_3 = 1 + 2 + 3 = 6, T_n = T_n-1 + 1 (hm, not sure if thats right)
# but the closed form is s_n = n/2(n+1), which is what I use below to find the nth triangular number.
#
# There is an awesome bit of magic in number theory; namely the following theorem.
#
# Theorem [Unique Prime Factorization]: Every integer N is the product of powers of prime numbers
#
# So any integer N = p^xp^yp^z..., that is every integer has a unique prime factorization. The number of
# occurances of each prime leads to a general pattern that describes the total number of factors for N.
# To find the factor count we just take the power of each of the prime factors, which is the multiplicity,
# (algebraic multiplicaity? (look that up_)) of each factor, add one to each, then multiply each. So for
# example if N = 2^2*5^2*7 then we can create a dictionary of counts such as:
#
# {
#   2: 2
#   5: 2
#   7: 1
# }
#
# From this we have everything we need to find the total number of factors, (2+1)(2+1)(1+1) = (3)(3)(2) = 18

# Find the nth triangular number
function triangular(n)::Integer
  (n*(n+1))/2
end

# Find the factor count for n, using the process outlined above
function findfactorcnt(n)
  reduce(*, map(x -> x + 1, values(countmap(factor(Vector, triangular(n))))))
end

# Problem 12: Highly divisible triangular numbers
function hdtn(max)
  n = 100
  factor_cnt = 0

  while factor_cnt < max
    cnt = findfactorcnt(n)
    if cnt > factor_cnt
      factor_cnt = cnt
      if factor_cnt > max
        break
      end
    end
    n += 1
  end

  println("$n has $factor_cnt factors")

  triangular(n)
end
