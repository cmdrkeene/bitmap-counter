# -*- mode: ruby; encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redis-bitmap-counter/version"

Gem::Specification.new do |s|
  s.name        = "redis-bitmap-counter"
  s.version     = RedisBitmapCounter::VERSION
  s.authors     = ["Brandon Keene"]
  s.email       = ["bkeene@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Efficient large dataset counters using redis bitmaps}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "redis"
  s.add_dependency "bitset"

  s.add_development_dependency "rspec", "~> 2.6.0"
end
