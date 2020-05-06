# The fibonacci sequence 0, 1, 1, 2, 3, 5, 8, 13,...
#
# F_(n+2) = F_(n+1) + F_n
# F_(n+1) = F_(n+1)
#
function fibonacci(n)
  u0 = [ 0 ; 1 ]
  A = [ 1 1 ; 1 0 ]
  # Solve[-x^2+x-1 == 0]
  lambda_1 = (1 + sqrt(5))/2
  lambda_2 = (1 - sqrt(5))/2
  S = [ lambda_1 lambda_2 ; 1 1 ]
  D = [ lambda_1 0 ; 0 lambda_2 ]
  # u0 = Sc => c = S^-1 u0
  c = inv(S)*u0
  try
    return Int(round(last(S*D^n*c)))
  catch err
    if isa(err, InexactError)
      return round(last(S*D^n*c))
    end
  end
end

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

function recursive_fibonacci(n)
  n == 1 && return 0
  n == 2 && return 1
  return recursive_fibonacci(n-1) + recursive_fibonacci(n-2)
end
