require 'bundler/setup'

require 'redcarpet'
require 'mustache'

require 'mustdown/engine'

module Mustdown
  class << self
    attr_accessor :markdown_extensions
    attr_accessor :renderer_options
    attr_accessor :renderer

    def configure
      yield self
    end

    def markdown_extensions
      @markdown_extensions ||= {
        no_intra_emphasis:  true,
        tables:             true,
        fenced_code_blocks: true,
        autolink:           true,
        strikethrough:      true
      }
    end

    def renderer_options
      @renderer_options ||= {
        no_styles:        true,
        safe_links_only:  true
      }
    end

    def renderer
      @renderer ||= Redcarpet::Render::HTML
    end
  end
end
