# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nfse_parser/version"

Gem::Specification.new do |s|
  s.name        = "nfse_parser"
  s.version     = NfseParser::VERSION
  s.authors     = ["Matheus Tardivo"]
  s.email       = ["matheustardivo@gmail.com"]
  s.homepage    = "https://github.com/matheustardivo/nfse_parser"
  s.summary     = %q{Parser de nota fiscal de serviço e gerador de arquivos para importação}
  s.description = s.summary

  s.rubyforge_project = "nfse_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"          , "~> 0.9"
  s.add_development_dependency "rspec"         , "~> 2.7"
  s.add_development_dependency "pry"           , "~> 0.9"
  s.add_development_dependency "awesome_print" , "~> 1.0"
  s.add_runtime_dependency "nokogiri"          , "~> 1.5"
end
