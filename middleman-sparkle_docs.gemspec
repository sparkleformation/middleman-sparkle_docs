# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-sparkle_docs"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Your Name"]
  s.email       = ["email@example.com"]
  s.homepage    = "http://example.com"
  s.summary     = %q{A short summary of your extension}
  s.description = %q{A longer description of your extension}

  s.files = Dir['lib/**/*'] + %w(middleman-sparkle_docs.gemspec)
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.4.0"])
  s.add_runtime_dependency 'sfn'
  s.add_runtime_dependency 'sparkle_formation'
  s.add_runtime_dependency 'sparkle-guides'
  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
