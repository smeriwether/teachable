# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "teachable/version"

Gem::Specification.new do |spec|
  spec.name          = "teachable"
  spec.version       = Teachable::VERSION
  spec.authors       = ["Stephen Meriwether"]
  spec.email         = ["smeriwether714@gmail.com"]

  spec.summary       = "Teachable Challenge Mock API Wrapper"
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.18"
  spec.add_development_dependency "pry", "~> 0.10.4"
end
