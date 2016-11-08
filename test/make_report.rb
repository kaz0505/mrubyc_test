require 'cgi'
require 'erb'
require 'json'
require 'forwardable'

if ARGV.size < 1
  raise "usage: #$0 TESTS_DIR"
end
tests_dir = ARGV[0]

def h(x); CGI.escapeHTML(x.to_s); end

class Test
  extend Forwardable

  def initialize(res_path)
    @data = JSON.parse(File.read(res_path))
  end

  def_delegators :@data, :[]
end

$tests = Dir["#{tests_dir}/test_*.rb"]
  .map{|x| Test.new(x.sub(/\.rb\z/, ".res"))}
erb = ERB.new(File.read("#{__dir__}/test_report.html.erb"))
puts erb.run(binding)
