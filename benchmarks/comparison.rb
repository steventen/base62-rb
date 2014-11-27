require_relative '../lib/base62-rb.rb'
require "benchmark"

# Results tested on Macbook Air 1.4 GHz Intel Core i5, 8 GB 1600 MHz DDR3
# Using Ruby 2.1.3p242

time = Benchmark.measure do
  1_000_000.times do |i|
    encode = Base62.encode(i)
    decode = Base62.decode(encode)
    raise "Assertion error!" unless i == decode
  end
end

puts time # => 3.430000   0.010000   3.440000 (  3.454776)


# https://github.com/jtzemp/base62
require 'base62'

time = Benchmark.measure do
  1_000_000.times do |i|
    encode = i.base62_encode
    decode = encode.base62_decode
    raise "Assertion error!" unless i == decode
  end
end

puts time # => 10.370000   0.030000  10.400000 ( 10.452976)