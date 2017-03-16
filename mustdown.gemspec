$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'mustdown/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mustdown'
  s.version     = Mustdown::VERSION
  s.authors     = ['Simon COURTOIS']
  s.email       = ['scourtois_github@cubyx.fr']
  s.homepage    = 'http://github.com/simonc/mustdown'
  s.summary     = 'Rails helpers to use Markdown and Mustache all together'
  s.description = 'Rails helpers to use Markdown and Mustache all together'

  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'redcarpet', '~> 3.2'
  s.add_dependency 'handlebars', '~> 0.7'

  s.add_development_dependency 'appraisal', '~> 2.1'
  s.add_development_dependency 'capybara', '~> 2.12'
  s.add_development_dependency 'coveralls', '~> 0.8'
  s.add_development_dependency 'guard', '~> 2.14'
  s.add_development_dependency 'guard-rspec', '~> 4.7'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rb-fchange', '~> 0.0.6'
  s.add_development_dependency 'rb-fsevent', '~> 0.9'
  s.add_development_dependency 'rb-inotify', '~> 0.9'
  s.add_development_dependency 'rspec-rails', '~> 3.5'
end
