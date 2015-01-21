# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gemgrapher/version', __FILE__)

Gem::Specification.new do |gem|  
  gem.authors       = ["Sushruth siv"]
  gem.email         = ["sivsushruth@gmail.com"]
  gem.description   = %q{Create gem dependency graph}
  gem.summary       = %q{CLI tool to generate gem dependency graph from your gemfile }
  gem.homepage      = "http://github.com/sivsushruth/gemgrapher"

  gem.files         = Dir['Rakefile', 'gemgrapher.gemspec', 'LICENSE.txt', 'README.md', 'lib/**/**/*', 'bin/*']# `git ls-files`.split($\)
  gem.executables   = ["gemgrapher"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gemgrapher"
  gem.require_paths = ["lib"]
  gem.version       = Gemgrapher::VERSION
  gem.add_runtime_dependency 'gemnasium'
  gem.add_runtime_dependency 'gemnasium-parser'
  gem.add_runtime_dependency 'json'
end  