require "capybara/rspec"

RSpec.configure do |config|
  config.include Capybara::DSL, type: :integration
end
