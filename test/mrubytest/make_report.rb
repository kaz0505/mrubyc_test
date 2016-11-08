require 'cgi'
require 'erb'
require 'json'
require 'forwardable'

def h(x); CGI.escapeHTML(x.to_s); end

class Test
  extend Forwardable

  def initialize(res_path)
    @data = JSON.parse(File.read(res_path))
  end

  def_delegators :@data, :[]
end

$tests = Dir["#{__dir__}/test_*.rb"]
  .map{|x| Test.new(x.sub(/\.rb\z/, ".res"))}
erb = ERB.new(File.read("#{__dir__}/mruby_report.html.erb"))
puts erb.run(binding)
