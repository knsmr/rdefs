# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "rdefs"
  s.version     = "0.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Minero Aoki"]
  s.email       = ["ken97531@gmail.com"]
  s.homepage    = "http://github.com/knsmr/rdefs"
  s.summary     = "A tool that extracts class, module and method definitions from Ruby source code."
  s.description = "A tool that extracts class, module and method definitions from Ruby source code."

  s.required_rubygems_version = ">= 1.3.6"
  s.files        = Dir.glob("{bin,lib,etc}/**/*") + %w(LICENSE README.md CHANGELOG.md)
  s.executables  = ['rdefs']
  s.require_path = 'lib'
end
