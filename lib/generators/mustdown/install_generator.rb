module Mustdown
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a default initializer for Mustdown'

      def copy_initializer
        template 'mustdown.rb', 'config/initializers/mustdown.rb'
      end
    end
  end
end
