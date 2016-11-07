require 'cgi'
require 'erb'
require 'json'

def h(x); CGI.escapeHTML(x.to_s); end

$tests = JSON.parse(File.read("#{__dir__}/mrubytest.json"))
erb = ERB.new(File.read("#{__dir__}/mruby_report.html.erb"))
puts erb.run(binding)

