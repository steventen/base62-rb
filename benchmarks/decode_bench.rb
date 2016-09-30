require 'benchmark/ips'

KEYS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
KEYS_HASH = KEYS.each_char.with_index.inject({}){|h,(k,v)| h[k]=v;h}
BASE = KEYS.length

### Decode Method Candidates =====

# The one that is used in base62-rb library
# Use 'while' loop, and define a variable i as the counter
def decode(str)
  num = 0
  i = 0
  len = str.length - 1
  while i < str.length
    pow = BASE ** (len - i)
    num += KEYS_HASH[str[i]] * pow
    i += 1
  end
  return num
end

# Use KEYS.index to get the index
# instead of using a predefined Hash Map(KEYS_HASH)
def decode1(str)
  num = 0
  i = 0
  while i < str.length
    pow = BASE ** (str.length - i -1)
    num += KEYS.index(str[i]) * pow
    i += 1
  end
  return num
end

# Use 'for...in...' loop
def decode2(str)
  num = 0
  for i in 0...str.length
    pow = BASE ** (str.length - i -1)
    num += KEYS_HASH[str[i]] * pow
  end
  return num
end

# Use String#each_char, and #with_index
# Use block to do the calcuation
def decode3(str)
  num = 0
  str.each_char.with_index do |char, i|
    pow = BASE ** (str.length - i -1)
    num += KEYS.index(char) * pow
  end
  return num
end

# Similar as above, but use KEYS_HASH to get the index
def decode4(str)
  num = 0
  str.each_char.with_index do |char, i|
    pow = BASE ** (str.length - i -1)
    num += KEYS_HASH[char] * pow
  end
  return num
end

# Similar as above, but explicitly define the counter
# without using #with_index
def decode5(str)
  num = 0
  i = 0
  str.each_char do |char|
    pow = BASE ** (str.length - i -1)
    num += KEYS_HASH[char] * pow
    i += 1
  end
  return num
end

# same thing but with less variable
def decode6(str)
  num = 0
  i = 0
  while i < str.length
    num += KEYS_HASH[str[i]] * (BASE ** (str.length - 1 - i))
    i += 1
  end
  return num
end

### ==================



### Testing =====

tests = ["A", "Jr", "DFL", "2B5S", "8zTZmv", "1AnE6bpNA", "hjNv8tS3K"]

Benchmark.ips do |x|
  x.report("decode") do
    tests.each do |test|
      decode(test)
    end
  end

  x.report("decode1") do
    tests.each do |test|
      decode1(test)
    end
  end

  x.report("decode2") do
    tests.each do |test|
      decode2(test)
    end
  end

  x.report("decode3") do
    tests.each do |test|
      decode3(test)
    end
  end

  x.report("decode4") do
    tests.each do |test|
      decode4(test)
    end
  end

  x.report("decode5") do
    tests.each do |test|
      decode5(test)
    end
  end

  x.report("decode6") do
    tests.each do |test|
      decode6(test)
    end
  end
end

### Results

# Results tested on Macbook Air 1.4 GHz Intel Core i5, 8 GB 1600 MHz DDR3
# Using Ruby 2.1.3p242

# Calculating -------------------------------------
#               decode      6677 i/100ms
#              decode1      5962 i/100ms
#              decode2      5535 i/100ms
#              decode3      4378 i/100ms
#              decode4      4502 i/100ms
#              decode5      5915 i/100ms
#              decode6      6443 i/100ms
# -------------------------------------------------
#               decode    67891.4 (±9.7%) i/s -     340527 in   5.069726s
#              decode1    62385.4 (±7.8%) i/s -     310024 in   5.000584s
#              decode2    57033.8 (±8.5%) i/s -     287820 in   5.082882s
#              decode3    45356.5 (±6.5%) i/s -     227656 in   5.041103s
#              decode4    47708.3 (±6.5%) i/s -     238606 in   5.023164s
#              decode5    64856.4 (±6.6%) i/s -     325325 in   5.038748s
#              decode6    67880.8 (±7.4%) i/s -     341479 in   5.059089s
