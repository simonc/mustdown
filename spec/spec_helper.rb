require 'bundler/setup'

Dir[File.join(__dir__, 'support', 'initializers', '*.rb')].each { |f| require f }

ENV["RAILS_ENV"] ||= 'test'
ENV["DATABASE_URL"] ||= 'sqlite3://localhost/:memory:'

TEST_TEMPLATES = {
  'layouts/application.html.erb' => '<%= yield %>',
  'testing/mustache.html.erb' => '<%= mustache "Hello {{name}}", name: "Mustache" %>',
  'testing/markdown.html.erb' => '<%= markdown "Hello Markdown" %>',
  'testing/mustdown.html.erb' => '<%= mustdown "Hello {{name}}", name: "Mustdown" %>'
}

require 'rails'
case Rails.version
when /^4\.2/
  require 'support/apps/rails-4.2'
when /^5\./
  require 'support/apps/rails-5.0'
else
  warn "Could not find a testing app for Rails version #{Rails.version.inspect}"
end
require 'rspec/rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.disable_monkey_patching!
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.filter_run_when_matching :focus
  config.infer_spec_type_from_file_location!
  config.order = :random
  # config.profile_examples = 10
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = false

  Kernel.srand config.seed
end
