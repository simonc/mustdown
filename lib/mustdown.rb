require 'bundler/setup'

require 'redcarpet'
require 'mustache'

require 'mustdown/engine' if defined?(Rails)

# Public: Provides a simple way to render markdown, mustache and
# mustache+markdown templates.
#
# Examples
#
#   # Rendering a markdown template.
#   tpl = 'This is **bold** and this is *italic*'
#   Mustdown.markdown(tpl)
#   # => '<p>This is <strong>bold</strong> and this is <em>italic</em></p>'
#
#   # Rendering a mustache template.
#   tpl = 'My name is {{name}} and I am {{age}}'
#   Mustdown.mustache(tpl, name: 'Tom', age: 20)
#   # => 'My name is Tom and I am 20'
#
#   # Rendering a mustache+markdown template.
#   tpl = '# More about {{name}}'
#   Mustdown.mustdown(tpl, name: 'Tom')
#   # => '<h1>More about Tom</h1>'
module Mustdown
  extend self

  # Public: Sets the Hash of markdown extensions.
  attr_writer :markdown_extensions

  # Public: Sets the Hash of markdown renderer options.
  attr_writer :renderer_options

  # Public: Sets the markdown renderer (a Redcarpet compatible renderer).
  #
  # Note: It accepts a class or an instance.
  attr_writer :markdown_renderer

  # Public: Provides a way to configure Mustdown.
  #
  # Yields itself.
  #
  # Examples
  #
  #   # Configuring Mustdown
  #   Mustdown.configure do |config|
  #     config.markdown_renderer = MyCustomRenderer
  #   end
  #
  # Returns nothing.
  def configure
    yield self
  end

  # Public: Returns the default markdown extensions
  #
  # Returns a Hash.
  def markdown_extensions
    @markdown_extensions ||= {
      no_intra_emphasis:  true,
      tables:             true,
      fenced_code_blocks: true,
      autolink:           true,
      strikethrough:      true
    }
  end

  # Public: Returns the default markdown renderer options
  #
  # Returns a Hash.
  def renderer_options
    @renderer_options ||= {
      no_styles:        true,
      safe_links_only:  true
    }
  end

  # Public: Returns the markdown renderer.
  #
  # This can be a class or an object. When it's a class, a new instance will be
  # created when rendering.
  #
  # Defaults to Redcarpet::Render::HTML
  #
  # Returns an Object.
  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Render::HTML
  end

  # Deprecated:  Returns the markdown renderer.
  #
  # Use markdown_renderer instead.
  #
  # Returns an Object.
  def renderer
    warn "Mustdown.renderer is deprecated. Use Mustdown.markdown_renderer instead."
    self.markdown_renderer
  end

  # Deprecated: Sets the markdown renderer
  #
  # Use markdown_renderer= instead.
  #
  # Returns nothing.
  def renderer=(value)
    warn "Mustdown.renderer= is deprecated. Use Mustdown.markdown_renderer= instead."
    self.markdown_renderer = value
  end

  # Public: Renders a markdown template.
  #
  # template            - The String template containing markdown template.
  # markdown_extensions - A Hash of additional extensions that will be merged
  #                       with the default ones.
  # renderer_options    - A Hash of additional markdown renderer options that
  #                       will be merged with the default ones.
  #
  # Examples
  #
  #    tpl = '# Hello world'
  #    Mustdown.markdown(tpl)
  #    # => '<h1>Hello world</h1>'
  #
  #    tpl = 'http://example.com [example](http://example.com)'
  #    Mustdown.markdown(tpl, autolink: false)
  #    # => '<p>http://example.com <a href="http://example.com">example</a></p>'
  #
  #    tpl = 'http://example.com [example](http://example.com)'
  #    Mustdown.markdown(tpl, { autolink: false }, { no_links: true })
  #    # => '<p>http://example.com [example](http://example.com)</p>'
  #
  # Returns the rendered markdown String.
  def markdown(template, markdown_extensions = {}, renderer_options = {})
    exts = markdown_extensions.merge(markdown_extensions)
    opts = renderer_options.merge(renderer_options)

    renderer = markdown_renderer.new(opts)
    markdown = Redcarpet::Markdown.new(renderer, exts)

    markdown.render(template)
  end

  # Public: Renders a mustache template.
  #
  # template - The String template containing mustache template.
  # resource - The Hash or Object used as binding for the template.
  #
  # Examples
  #
  #    tpl = 'Hello {{name}}'
  #    Mustdown.mustache(tpl, name: 'Tom')
  #    # => 'Hello Tom'
  #
  #    tpl = 'Hello {{name}}'
  #    user = User.find(1) # A user named Tom
  #    Mustdown.mustache(tpl, user)
  #    # => 'Hello Tom'
  #
  # Returns the rendered mustache String.
  def mustache(template, resource)
    Mustache.render(template, resource)
  end

  # Public: Renders a mustache+markdown template.
  #
  # template      - The String template containing mustache+markdown template.
  # resource      - The Hash or Object used as binding for the template.
  # markdown_args - Zero, one or two Hash objects that will be passed to the
  #                 markdown method.
  #
  # Examples
  #
  #    tpl = '# Hello {{name}}'
  #    Mustdown.mustdown(tpl, name: 'Tom')
  #    # => '<h1>Hello Tom</h1>'
  #
  #    tpl = '{{url}}'
  #    website = { url: 'http://example.com' }
  #    Mustdown.markdown(tpl, website, autolink: false)
  #    # => '<p>http://example.com</p>'
  #
  #    tpl = '[{{title}}]({{url}})'
  #    website = { title: 'Example', url: 'http://example.com' }
  #    Mustdown.markdown(tpl, website, { autolink: false }, { no_links: true })
  #    # => '<p>[Example](http://example.com)</p>'
  #
  # Returns the rendered mustache+arkdown String.
  def mustdown(template, resource, *markdown_args)
    markdown mustache(template, resource), *markdown_args
  end

  # Private: Outputs a warning message.
  #
  # In a Rails app uses Rails.logger, $stderr otherwise.
  #
  # message - The String message to display as a warning.
  #
  # Returns nothing.
  def warn(message)
    if defined?(Rails)
      Rails.logger.warn message
    else
      $stderr.puts "WARNING: #{message}"
    end
  end
end
