# Sift the Two's and Sift the Three's,
# The Sieve of Eratosthenes.
# When the multiples sublime,
# The numbers that remain are Prime.
function sieve(n)
  c = 2
  primes = Array(c:n)
  while c < primes[length(primes)]
    primes = filter(x -> x == c || x % c != 0, primes)
    c = primes[findfirst(x -> x > c, primes)]
  end
  return primes
end

# Dumb mode validation
function validate_is_prime(number)
  for j = 2:number-1
    if j % number == 0
      return false
    end
  end
  return true
end
