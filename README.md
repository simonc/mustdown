# Mustdown [![Build Status](https://api.travis-ci.org/simonc/mustdown.svg?branch=master)](http://travis-ci.org/simonc/mustdown) [![Code Climate](https://codeclimate.com/github/simonc/mustdown.svg)](https://codeclimate.com/github/simonc/mustdown) [![Coverage Status](https://coveralls.io/repos/simonc/mustdown/badge.svg?branch=master)](https://coveralls.io/r/simonc/mustdown?branch=master)

Mustdown provides helpers to ease the use of markdown, mustache and both of
them.

## Installation

Add the gem to your `Gemfile` :

    gem 'mustdown'

Then call `bundle install` to install it for your application.

## Usage in Rails

### markdown

This will render the given text through Markdown.

``` html_rails
<%= markdown "# Hello World" %>
```

Output:

``` html
<h1>Hello World</h1>
```

### mustache

The `mustache` helper renders a mustache template with the given binding object.

``` html_rails
<%= mustache "Hello {{name}}", name: 'John' %>
```

Output:

``` html
Hello John
```

### mustdown

This helper is more complex since it provides the two previous helpers in one.

``` html_rails
<%= mustdown "# {{title}}", title: 'Hello World' %>
```

Output:

``` html
<h1>Hello World</h1>
```

## Usage outside of Rails

If you're not using Rails, it's possible to use the Mustdown module directly.

### markdown

This will render the given text through Markdown.

``` ruby
Mustdown.markdown("# Hello World")
# => "<h1>Hello World</h1>"
```

### mustache

The `mustache` method renders a mustache template with the given binding object.

``` ruby
Mustdown.mustache("Hello {{name}}", name: 'John')
# => "Hello John"
```

### mustdown

This method is more complex since it provides the two previous methods in one.

``` ruby
Mustdown.mustdown("# {{title}}", title: 'Hello World')
# => "<h1>Hello World</h1>"
```

## Mustdown configuration

You can generate a default initializer by calling:

    bundle exec rails generate mustdown:install

The markdown configuration is provided by Redcarpet. All Redcarpet options are
available.

### Overriding the configuration from the view

The `markdown` and `mustdown` helpers accept additional parameters for markdown
configuration. The settings you pass are merged with the default ones and take
precedence.

``` ruby
<%= markdown "**Hello World**", { autolink: false }, { hard_wrap: true} %>
```

## Using with I18n

A very useful technique is to use templates from I18n.

Let's take an example. Given the following models in your app:

![Company(name) -> Project(title,url)](http://yuml.me/626df1f5)

Define the following in `config/locales/en.yml`:

``` yaml
en:
  companies:
    show:
      text: |
        # {{name}}

        {{name}} is a great company ! Here are some of their projects:

        {{#projects}}
        * [{{title}}]({{url}})
        {{/projects}}
```

Now we can use it in our show template (located in
`app/views/companies/show.html.erb`):

``` html_rails
<%= mustdown t('.text'), @company %>
```

Output:

``` html
<h1>Github</h1>

<p>Github is a great company ! Here are some of their projects:</p>

<ul>
  <li><a href="https://github.com/github/hubot">Hubot</a></li>
  <li><a href="https://github.com/github/gollum">Gollum</a></li>
</ul>
```

## Usage as a helper

### ActionMailer

It is possible to use Mustdown when composing your emails but to do so you need to reference it as a helper

``` ruby
class MyAwesomeMailer < ActionMailer::Base
  helper :'mustdown/mustdown'

  # ...
end
```

### Cells

If you try to use Mustdown with Cells, you need to add it as a helper like this:

``` ruby
class HomeListingsCell < Cell::Rails
  helper :'mustdown/mustdown'

  # ...
end
```
