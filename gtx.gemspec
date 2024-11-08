lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtx/version'

Gem::Specification.new do |s|
  s.name        = 'gtx'
  s.version     = GTX::VERSION
  s.summary     = 'GTX Template Engine'
  s.description = 'Create templates that transpile to ERB'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/dannyben/gtx'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.0'

  s.add_dependency 'erb', '~> 4.0'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/gtx/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/gtx/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/dannyben/gtx',
    'rubygems_mfa_required' => 'true',
  }
end
