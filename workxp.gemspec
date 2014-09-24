# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'workxp/version'

Gem::Specification.new do |spec|
  spec.name          = "workxp"
  spec.version       = Workxp::VERSION
  spec.authors       = ["Yuan Ping"]
  spec.email         = ["yp.xjgz@gmail.com"]
  spec.description   = %q{A Ruby interface to the WorkXP API.}
  spec.summary       = %q{A Ruby interface to the WorkXP API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "oauth2"
end
