module Mustdown
  module MustdownHelper
    def markdown(content, markdown_extensions = {}, renderer_options = {})
      md_exts = Mustdown.markdown_extensions.merge(markdown_extensions)
      renderer_opts = Mustdown.renderer_options.merge(renderer_options)

      renderer = Mustdown.renderer.new(renderer_opts)
      markdown = Redcarpet::Markdown.new(renderer, md_exts)

      markdown.render(content).html_safe
    end

    def mustache(template, resource)
      Mustache.render(template, resource).html_safe
    end

    def mustdown(template, resource, *markdown_args)
      markdown mustache(template, resource), *markdown_args
    end
  end
end
