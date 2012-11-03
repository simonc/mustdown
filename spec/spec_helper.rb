require 'bundler'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Bundler.setup

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }