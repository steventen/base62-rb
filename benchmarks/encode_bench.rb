require 'benchmark/ips'

KEYS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
KEYS_HASH = KEYS.each_char.with_index.inject({}){|h,(k,v)| h[k]=v;h}
BASE = KEYS.length

### Encode Method Candidates =====

# The one that is used in base62-rb library
# Use '+' to prepend string
def encode(num)
  return "0" if num == 0
  return nil if num < 0

  str = ""
  while num > 0
    str = KEYS[num % BASE] + str
    num = num / BASE
  end
  return str
end

# Use String#reverse method at the end
def encode1(num)
  return "0" if num == 0
  return nil if num < 0

  str = ""
  while num > 0
    str = str + KEYS[num % BASE]
    num = num / (BASE)
  end
  return str.reverse
end


# Use String#prepend method
def encode2(num)
  return "0" if num == 0
  return nil if num < 0

  str = ""
  while num > 0
    str.prepend KEYS[num % BASE]
    num = num / (BASE)
  end
  return str
end

# Use the '/=' way
def encode3(num)
  return "0" if num == 0
  return nil if num < 0

  str = ""
  while num > 0
    str = KEYS[num % BASE] + str
    num /= BASE
  end
  return str
end

# Use #<< to append string
def encode4(num)
  return "0" if num == 0
  return nil if num < 0

  str = ""
  while num > 0
    str << KEYS[num % BASE]
    num /= BASE
  end
  return str.reverse
end

### ==================



### Testing =====

tests_encode = [630, 1231, 902323, 3781504209452600, 18446744073709551615]

Benchmark.ips do |x|
  x.report("encode") do
    tests_encode.each do |test|
      encode(test)
    end
  end

  x.report("encode1") do
    tests_encode.each do |test|
      encode1(test)
    end
  end

  x.report("encode2") do
    tests_encode.each do |test|
      encode2(test)
    end
  end

  x.report("encode3") do
    tests_encode.each do |test|
      encode3(test)
    end
  end

  x.report("encode4") do
    tests_encode.each do |test|
      encode4(test)
    end
  end
end

### Results

# Results tested on Macbook Air 1.4 GHz Intel Core i5, 8 GB 1600 MHz DDR3
# Using Ruby 2.1.3p242

# Calculating -------------------------------------
#               encode      9141 i/100ms
#              encode1      8231 i/100ms
#              encode2      7222 i/100ms
#              encode3      9040 i/100ms
#              encode4      8660 i/100ms
# -------------------------------------------------
#               encode    97414.2 (±8.1%) i/s -     484473 in   5.008219s
#              encode1    89976.1 (±6.5%) i/s -     452705 in   5.053138s
#              encode2    76680.4 (±6.8%) i/s -     382766 in   5.015263s
#              encode3    94348.1 (±8.2%) i/s -     470080 in   5.016213s
#              encode4    86996.4 (±8.7%) i/s -     433000 in   5.016085s
