# GTX - Minimal Template Engine

[![Gem Version](https://badge.fury.io/rb/gtx.svg)](https://badge.fury.io/rb/gtx)
[![Build Status](https://github.com/DannyBen/gtx/workflows/Test/badge.svg)](https://github.com/DannyBen/gtx/actions?query=workflow%3ATest)

---

GTX is a minimal template engine that transpiles to ERB before using it to 
generate the output.

As opposed to ERB, GTX is a code-first template engine - where Ruby code does
not need to be enclosed in tags. Instead, the output of the template needs to
be marked with a "Greater Than" sign (hence the name).

## Install

```bash
$ gem install gtx
```

## Template Syntax

### Summary

GTX converts your template code to ERB before rendering its output. 

<table>
<tr><th>GTX</th><th>ERB</th></tr>
<tr><td>

```ruby
> any text
> inline code: {{ "hello " * 3 }}
>          or: <%= "world " * 3 %>

3.times do |i|
  > loopy text {{ i + 1 }}
end

= user.welcome_message
```
      
</td><td>

```ruby
any text
inline code: <%= "hello " * 3 %>
         or: <%= "world " * 3 %>

<%- 3.times do |i| -%>
loopy text <%= i + 1 %>
<%- end -%>

<%= user.welcome_message %>
```

</td></tr></table>

The conversion is specifically kept at 1:1 ratio, so that the correct line number
can be referenced in case of an error.

### Explanation

Lines starting with `>` are treated as output. Any number of spaces before and
one space after the `>` are ignored:

```ruby
> this line will output as is
```

Using `{{ ... }}` in an output line executes inline ruby code, as if it is
ERB's `<%= ... %>` syntax:

```ruby
> any ruby code: {{ "hello " * 3 }}
```

Lines starting with `=` can be used to execute ruby code that returns a string
that is expected to be a part of the output.

```ruby
= user.welcome_message(:morning)
# which is a shortcut to:
> {{ user.welcome_message(:morning) }}
```

Any other line, will be treated as Ruby code and will be enclosed using ERB's 
`<%- ... -%>` syntax.

See the [example template](examples/full.rb) for additional nuances.

## Usage

### Using a GTX Instance

```ruby
require 'gtx'

# Create an instance
path = "path/to/template_file"
template = File.read path
gtx = GTX.new template, filename: path

# Parse it with optional context
gtx.parse any_object

# ... or with local binding
gtx.parse binding

# Get the ERB source
gtx.erb_source

# ... or the ERB object
gtx.erb

```

### Class Shortcuts

```ruby
require 'gtx'

# One-liner render template from file
GTX.render_file path

# ... with a context or Binding object
GTX.render_file path, context: any_object

# Get an instance, and parse later
gtx = GTX.load_file path
gtx.parse optional_context_object

# Render from string
GTX.render string, context: optional_object, filename: optional_filename
```


## But... why?

GTX was created to provide a code-first alternative to ERB, specifically for 
the code generation templates used by [Bashly][bashly]. Enclosing Ruby code
inside ERB tags, and ensuring there are no excess empty lines in the ERB
template yielded some hard-to-maintain templates.


## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

---

[issues]: https://github.com/DannyBen/gtx/issues
[bashly]: https://bashly.dannyb.co/

