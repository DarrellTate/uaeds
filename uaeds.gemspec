# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uaeds/version'

Gem::Specification.new do |spec|
  spec.name          = "uaeds"
  spec.version       = Uaeds::VERSION
  spec.authors       = ["dgsan"]
  spec.email         = ["dgsan@gmx.com"]
  spec.description   = "Tool for working with UA's 'Enterprise Directory Service,' an XML-based (DSML) (or JSON-based) lookup service."
  spec.summary       = 'Tool for working with UA EDS'
  spec.homepage      = "https://github.com/dgsan/uaeds"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.3"
  spec.add_development_dependency 'rake', "~> 10.1"
  spec.add_development_dependency 'rspec', "~> 2.6"
  spec.add_development_dependency 'highline', "~> 1.6"
  spec.add_runtime_dependency 'nokogiri', "~> 1.6"
  spec.add_runtime_dependency 'json', "~> 1.8"

end
