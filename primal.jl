# Sift the Two's and Sift the Three's,
# The Sieve of Eratosthenes.
# When the multiples sublime,
# The numbers that remain are Prime.
function sieve(n)
  primes = fill(true, n)
  primes[1] = false
  for p = 2:n
    primes[p] || continue
    for i = 2:div(n, p)
      primes[p*i] = false
    end
  end
  findall(primes)
end

function prime(n)
  # A pretty good upper bound, although probably not perfect for really really big n
  pn_upper = n <= 20 ? BigInt(n*(log(n)+2)) : BigInt(ceil(n * (log(n) + log(log(n)) - 0.5)))
  sieve(pn_upper)[n]
end

function primes(low, high)
  pn_upper = high <= 20 ? BigInt(high*(log(high)+2)) : BigInt(ceil(high * (log(high) + log(log(high)) - 0.5)))
  filter(x -> low < x < high, sieve(high))
end
