require 'rubygems'
require 'bundler/setup'

#
# Bundler related tasks
#

require 'bundler/gem_tasks'

#
# RSpec related tasks
#

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

default_task = :spec

#
# Appraisal related tasks
#

require 'appraisal'

unless ENV['APPRAISAL_INITIALIZED'] || ENV['TRAVIS']
  default_task = :appraisal
end

#
# RDOC related tasks
#

begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Mustdown'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

#
# Default task
#

task default: default_task
