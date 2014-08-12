# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanlon/api/version'

Gem::Specification.new do |spec|
  spec.name          = "hanlon-api"
  spec.version       = Hanlon::Api::VERSION
  spec.authors       = ["John Ewart"]
  spec.email         = ["john@unixninjas.org"]
  spec.summary       = %q{HTTP API Gem for talking to Hanlon}
  spec.description   = %q{Ruby gem for using the Hanlon HTTP API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'
  spec.add_dependency 'json'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
