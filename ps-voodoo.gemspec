# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "voodoo/version"

Gem::Specification.new do |s|
  s.name        = "ps-voodoo"
  s.version     = Voodoo::VERSION
  s.authors     = ["JR Bing"]
  s.email       = ["jrbing@gmail.com"]
  s.homepage    = "https://github.com/jrbing/ps-voodoo"
  s.summary     = %q{Black magic utility for PeopleSoft administration}
  s.description = %q{A small command line utility for helping with PeopleSoft administration}

  s.add_dependency("commander", ["= 4.0.4"])
  s.add_dependency("terminal-table", [">= 1.4.2"])

  s.rubyforge_project = "ps-voodoo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
