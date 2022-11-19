require 'simplecov'
unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch
  end
end

require 'bundler'
Bundler.require :default, :development

# Consistent output (for rspec_approvals)
ENV['TTY'] = 'off'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

require_relative 'fixtures/mock_context'

RSpec.configure do |c|
  c.strip_ansi_escape = true
end
