module Mustdown
  class Engine < ::Rails::Engine
    # Disable specs generation
    config.generators do |g|
      g.test_framework :rspec, view_specs: false
    end

    # Register MustdownHelper as a Rails helper
    initializer 'mustdown.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Mustdown::MustdownHelper
      end
    end
  end
end
