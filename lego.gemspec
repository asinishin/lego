# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lego/version"

Gem::Specification.new do |s|
  s.name        = "lego"
  s.version     = Lego::VERSION
  s.authors     = ["Alex Sinishin"]
  s.email       = ["sinishin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Another scraper}
  s.description = %q{Nobel laureats scraping}

  s.rubyforge_project = "lego"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr",              "~> 2.2.3"
  s.add_development_dependency "fakeweb",          "~> 1.3.0"
  s.add_development_dependency "rake"

  s.add_runtime_dependency     "rest-client"
  s.add_runtime_dependency     "nokogiri"
end
