require "action_controller/railtie"
require "action_view/railtie"
require 'action_view/testing/resolvers'

require 'mustdown'

module Rails42
  class Application < Rails::Application
    config.root = File.expand_path("../../..", __FILE__)
    config.cache_classes = true

    config.eager_load = false
    config.serve_static_files = true
    config.static_cache_control = 'public, max-age=3600'

    config.condiser_all_requests_local = true
    config.action_controller.perform_caching = false

    config.action_dispatch.show_exceptions = false

    config.action_controller.allow_forgery_protection = false

    config.active_support.deprecation = :stderr

    config.middleware.delete Rack::Lock
    config.middleware.delete ActionDispatch::Flash

    config.secret_key_base = 'xxx123xxx'

    routes.append do
      get '/mustache' => 'testing#mustache'
      get '/markdown' => 'testing#markdown'
      get '/mustdown' => 'testing#mustdown'
    end
  end
end

Rails42::Application.initialize!

class TestingController < ActionController::Base
  include Rails.application.routes.url_helpers
  layout 'application'
  self.view_paths = [ActionView::FixtureResolver.new(TEST_TEMPLATES)]
end
