# Public: Wrapper class for Mustdown.
#
# This module is a Rails helper that provides an easy access to the Mustdown
# rendering methods.
module Mustdown
  module MustdownHelper
    # Public: Calls Mustdown.markdown.
    #
    # See Mustdown.markdown.
    def markdown(*args)
      Mustdown.markdown(*args).html_safe
    end

    # Public: Calls Mustdown.mustache.
    #
    # See Mustdown.mustache.
    def mustache(*args)
      Mustdown.mustache(*args).html_safe
    end

    # Public: Calls Mustdown.mustdown.
    #
    # See Mustdown.mustdown.
    def mustdown(*args)
      Mustdown.mustdown(*args).html_safe
    end
  end
end
