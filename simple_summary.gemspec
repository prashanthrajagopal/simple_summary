# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_summary/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_summary"
  spec.version       = SimpleSummary::VERSION
  spec.authors       = ["Prashanth Rajagopal"]
  spec.email         = ["prashanth.rajagopal@gmail.com"]
  spec.summary       = %q{A naive text summarization tool}
  spec.description   = %q{A naive algorithm to summarize a piece of text}
  spec.homepage      = "http://www.prashanthr.net/2014/02/summarize-chunk-of-text-with-ruby.html"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 0"
end
