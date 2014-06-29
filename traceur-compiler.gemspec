# -*- encoding: utf-8 -*-
require File.expand_path("../lib/traceur-compiler/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Julien Portalier"]
  gem.email         = ["julien@portalier.com"]
  gem.description   = gem.summary = "Ruby integration for the ES6 to ES5 Traceur compiler"
  gem.homepage      = "http://github.com/ysbaddaden/traceur-compiler"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split("\n")
  gem.name          = "traceur-compiler"
  gem.require_paths = ["lib"]
  gem.version       = TraceurCompiler::VERSION::STRING

  gem.cert_chain    = ["certs/ysbaddaden.pem"]
  gem.signing_key   = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  gem.add_dependency "execjs"
  gem.add_dependency "activesupport", ">= 3.0.0"

  gem.add_development_dependency "minitest", "~> 5.0"
end
