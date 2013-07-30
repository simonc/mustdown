$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mustdown/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mustdown"
  s.version     = Mustdown::VERSION
  s.authors     = ["Simon COURTOIS"]
  s.email       = ["scourtois+cubyx@cubyx.fr"]
  s.homepage    = "http://github.com/simonc/mustdown"
  s.summary     = "Rails helpers to use Markdown and Mustache all together"
  s.description = "Rails helpers to use Markdown and Mustache all together"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.1"
  s.add_dependency "redcarpet", ">= 2.0.0"
  s.add_dependency "mustache", ">= 0.99.4"

  s.add_development_dependency "coveralls", "~> 0.6"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
