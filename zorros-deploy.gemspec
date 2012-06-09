# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "zorros-deploy/version"

Gem::Specification.new do |s|
  s.name        = "zorros-deploy"
  s.version     = Zorros::Deploy::VERSION
  s.authors     = ['Francisco J. Casas, Zorros']
  s.email       = ['fran@zorros.be']
  s.homepage    = 'http://github.com/Zorros/zorros-deploy'
  s.summary     = %q{Some common capistrano tasks for all our applications}
  s.description = %q{Some common capistrano tasks for all our applications}

  s.rubyforge_project = "zorros-deploy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'capistrano'
  s.add_runtime_dependency 'git'
  s.add_runtime_dependency 'grit'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
