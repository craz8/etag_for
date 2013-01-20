# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'etag_for/version'

Gem::Specification.new do |gem|
  gem.name          = "etag_for"
  gem.version       = EtagFor::VERSION
  gem.authors       = ["Tom Fakes"]
  gem.email         = ["tom@craz8.com"]
  gem.description   = "Provide etag support for actions with views and layouts"
  gem.summary       = "Allow an action to include CSS, Javascript, View and Layout code as pieces for the calculation of an action's ETAG header"
  gem.homepage      = "https://github.com/craz8/etag_for"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport", ">= 3.0"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "mocha"
end
