# -*- mode: ruby; encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bitmap/counter"

Gem::Specification.new do |s|
  s.name        = "bitmap-counter"
  s.version     = Bitmap::Counter::VERSION
  s.authors     = ["Brandon Keene"]
  s.email       = ["bkeene@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A unique id counter implemented with redis bitmaps. Count the unique users across a date range.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "redis"
  s.add_dependency "bitset"

  s.add_development_dependency "rspec", "~> 2.6.0"
end
