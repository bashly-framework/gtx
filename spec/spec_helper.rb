require 'simplecov'
SimpleCov.start

require 'bundler'
Bundler.require :default, :development

# Consistent output (for rspec_approvals)
ENV['TTY'] = 'off'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

RSpec.configure do |c|
  c.strip_ansi_escape = true
end
