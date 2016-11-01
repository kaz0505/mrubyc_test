require 'cgi'
require 'erb'

def h(str); CGI.escapeHTML(str); end

OUTS = Dir["#{__dir__}/*.out"]

erb = ERB.new(File.read("#{__dir__}/basic_report.html.erb"))
puts erb.run(binding)
