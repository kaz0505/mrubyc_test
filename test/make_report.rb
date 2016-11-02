require 'cgi'
require 'erb'

if ARGV.size < 1
  raise "usage: #$0 TESTS_DIR"
end
tests_dir = ARGV[0]

def h(str); CGI.escapeHTML(str); end

class Test
  def initialize(rb_path)
    @rb_path = rb_path
    @out_path = @rb_path.sub(".rb", ".out")
  end
  attr_reader :rb_path, :out_path

  def rb_txt
    @rb_txt ||= File.read(rb_path)
  end

  def out_txt
    @out_txt ||= File.read(out_path)
  end
end

$tests = Dir["#{tests_dir}/test_*.rb"]
  .map{|x| Test.new(x)}
  .sort_by{|x| x.rb_txt.length}
erb = ERB.new(File.read("#{__dir__}/test_report.html.erb"))
puts erb.run(binding)
