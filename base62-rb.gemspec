# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'base62/version'

Gem::Specification.new do |spec|
  spec.name          = "base62-rb"
  spec.version       = Base62::VERSION
  spec.authors       = ["Steven Yue"]
  spec.email         = ["jincheker@gmail.com"]
  spec.summary       = "Base62 encoding and decoding in Ruby"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/steventen/base62-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
