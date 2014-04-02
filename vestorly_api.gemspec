# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vestorly_api/version'

Gem::Specification.new do |spec|
  spec.name          = "vestorly_api"
  spec.version       = VestorlyApi::VERSION
  spec.authors       = ["David Rodas"]
  spec.email         = ["ddreliv@gmail.com"]
  spec.summary       = %q{Vestorly API integration.}
  spec.description   = %q{The Vestorly API provides the ability for external
                          developers to synchronize their client data with Vestorly.
                          The API provides support for CRM integration, content
                          curation, client behavior monitoring, and compliance
                          monitoring software.}
  spec.homepage      = "https://www.vestorly.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "webmock", "~>0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "turn", "~> 0"
  spec.add_development_dependency "rspec", "~> 2.6"

  spec.add_runtime_dependency "httparty", "~> 0"
end
