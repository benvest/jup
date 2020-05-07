# The fibonacci sequence 0, 1, 1, 2, 3, 5, 8, 13,...
#
# F_(n+2) = F_(n+1) + F_n
# F_(n+1) = F_(n+1)
#
# The idea for this one came from a linear algebra lecture (22) by Strang.
function fibonacci(n)
  u0 = [ 0 ; 1 ]
  A = [ 1 1 ; 1 0 ]
  # Solve[-x^2+x-1 == 0]
  lambda_1 = (1 + sqrt(big(5)))/2
  lambda_2 = (1 - sqrt(big(5)))/2
  S = [ lambda_1 lambda_2 ; 1 1 ]
  D = [ lambda_1 0 ; 0 lambda_2 ]
  # u0 = Sc => c = S^-1 u0
  c = inv(S)*u0
  return BigInt(round(last(S*D^n*c)))
end

function recursive_fibonacci(n)
  n == 1 && return 0
  n == 2 && return 1
  return recursive_fibonacci(n-1) + recursive_fibonacci(n-2)
end

#  Binet formula
function binetfib(n)
  return ((1+sqrt(big(5)))^n-(1-sqrt(big(5)))^n)/(sqrt(big(5))*big(2)^n)
end

# This one is the winner by a nice margin in allocations and time.
#
# I stole this from somewhere, need to find where sometime (stack overflow?)
const fibmem = Dict{Int,BigInt}()
function memfib(n)
  get!(fibmem, n) do
    if n <= 0
      return BigInt(0)
    elseif n == 1
      return BigInt(1)
    else
      m = n >> 1
      if iseven(n)
        return memfib(m)*(2*memfib(m-1) + memfib(m))
      else
        return memfib(m+1)^2 + memfib(m)^2
      end
    end
  end
end

# helper generators

function generate(from, to)
  fibs = []
  for j = from:to
    push!(fibs, fibonacci(j))
  end
  return fibs
end

function generate(n)
  return generate(1, n)
end
