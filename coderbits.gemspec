# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "coderbits/version"

Gem::Specification.new do |s|
  s.name = "coderbits"
  s.version = Colos::VERSION
  s.authors = ["Yuri Artemev"]
  s.email = ["i@artemeff.com"]
  s.homepage = "http://github.com/artemeff/coderbits"
  s.description = %q{Simple wrapper for the Coderbits API}
  s.summary = %q{Coderbits API wrapper}
  s.files = %w(CHANGELOG.md README.md LICENSE Rakefile coderbits.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*")
  s.licenses = ['MIT']
  s.require_paths = ['lib']
  s.test_files = Dir.glob("spec/**/*")

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_dependency 'faraday', '~> 0.8'
  s.add_dependency 'multi_json', '~> 1.3'
  s.add_dependency 'sprite-factory', '~> 1.5'
  s.add_dependency 'chunky_png', '~> 1.2'
end
