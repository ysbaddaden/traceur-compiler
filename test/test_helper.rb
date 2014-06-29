require "bundler"
Bundler.setup(:default)

require "minitest/autorun"
require "minitest/pride"
require "traceur-compiler"

TraceurCompiler::Source.path = File.expand_path("../../node_modules/traceur/bin/traceur.js", __FILE__)
