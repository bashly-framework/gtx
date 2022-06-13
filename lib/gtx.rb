if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

require 'erb'

class GTX
  VERSION = "0.1.0"

  class << self
    def render(template, context: nil, filename: nil)
      new(template, filename: filename).parse context
    end

    def load_file(path)
      new(File.read(path), filename: path)
    end

    def render_file(path, context: nil)
      load_file(path).parse context
    end
  end

  attr_reader :template, :filename

  def initialize(template, filename: nil)
    @template, @filename = template, filename
  end

  def erb_source
    template.each_line.map do |line|
      case line
      when /^\s*> ?(.*)/ then eval_vars $1
      when /^\s*= ?(.*)/ then "<%= #{eval_vars $1.strip} %>"
      else "<%- #{line.strip} -%>"
      end
    end.join "\n"
  end

  def erb
    ERB.new(erb_source, trim_mode: '-').tap { |a| a.filename = filename }
  end
  
  def parse(context = nil)
    context ||= self
    erb.result context.instance_eval { binding }
  end

protected

  def eval_vars(string)
    string.gsub(/{{(.*?)}}/, '<%= \1 %>')
      .gsub(/\\\}\\\}/, '}}')
      .gsub(/\\\{\\\{/, '{{')
  end

end
