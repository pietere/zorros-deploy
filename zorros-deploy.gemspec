# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "zorros-deploy/version"

Gem::Specification.new do |s|
  s.name        = "zorros-deploy"
  s.version     = Zorros::Deploy::VERSION
  s.authors     = ["Francisco J. Casas, Zorros"]
  s.email       = ["hello@zorros.be"]
  s.homepage    = ""
  s.summary     = %q{Some common capistrano tasks for all our applications}
  s.description = %q{Some common capistrano tasks for all our applications}

  s.rubyforge_project = "zorros-deploy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "capistrano"
end
