# lines that start with > are used literally
# the first space after the > is optional
# and lines with just > are also used as is (empty output line)
# This is converted to ERB's <%= tag
> first line
>second line
>

# Other lines are just ruby code which will be converted to ERB's <%- tag
# Anything formatted as {{ ... }} is converted to ERB's <%= tag
3.times do |i|
  > {{ " " * i * 2 }}  this is loopy {{ i }}
end
>

# Any method from the context object can be used
if user == 'admin'
  > Welcome admin
  > WARNING: YOU HAVE ADMIN RIGHTS
else
  > Welcome {{ user }}
end

# In order to use literal {{ or }}, escape them
> \{\{ not ruby code \}\}
>

# Start a line with = to call rnby ruby code that returns a string. The string
# will be appended to the output using ERB's <%= tag
= "hello " * 3

# ... which is a shortcut to
> {{ "..." }}

# Triple braces will be handled properly (will output "{output}")
> {{{ "output" }}}

# Standard ERB output tags can also be used
> <%= "erb" %> together with {{ "gtx tags" }}
