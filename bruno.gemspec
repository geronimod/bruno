# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bruno/version'

Gem::Specification.new do |gem|
  gem.name          = "bruno"
  gem.version       = Bruno::VERSION
  gem.authors       = ["Geronimo Diaz"]
  gem.email         = ["geronimod@gmail.com"]
  gem.description   = %q{Street + Housenumber mapping to OSM data. Given a street and a housenumber, bruno returns osm data }
  gem.summary       = %q{Street + Housenumber mapping to OSM data}
  gem.homepage      = "https://github.com/geronimod/bruno"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
