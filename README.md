# Base62 in Ruby

A simple and fast implementation of base62 in Ruby without too much sugar and magic. 

It uses character set: `0-9`, `a-z`, `A-Z` for encoding and decoding.

Base62 is usually used for short URLs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'base62-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install base62-rb

## Usage

```ruby
require 'base62-rb'

Base62.encode(3781504209452600)
# => "hjNv8tS3K"

Base62.decode("hjNv8tS3K")
# => 3781504209452600
```

## License

MIT License - Copyright (c) 2014 Steven Yue