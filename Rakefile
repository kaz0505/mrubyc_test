require 'json'
require 'yaml'
require 'tempfile'

class Conf
  def initialize(path)
    @yaml = YAML.load_file(path)
  end

  def mruby_path; File.expand_path(@yaml[:mruby_path]); end
  def mrubyc_path
    ENV["ENGINE"] or
    File.expand_path(@yaml[:mrubyc_path])
  end

  def mrbc; File.join(mruby_path, "bin/mrbc"); end
  def mrubyc; File.join(mrubyc_path, "sample_c/mrubyc"); end
end

module Test
  extend FileUtils

  def self.compile(header, rb_path, mrb_path)
    f = Tempfile.new(File.basename(rb_path))
    f.write(header + File.read(rb_path))
    f.close
    sh "#{$conf.mrbc} -E -o #{mrb_path} #{f.path}"
  end

  def self.run(rb_path, mrb_path, res_path)
    cmd = "#{$conf.mrubyc} #{mrb_path} 2>&1"
    puts cmd
    out = `#{cmd}`
    if $?.exitstatus == 139
      if File.exist?("core")
        out << `gdb -batch -c core -ex bt`
      else
        puts "Detected SEGV but core file not found"
      end
    end
    data = {
      rb_path: rb_path,
      title: File.basename(rb_path),
      rb_txt: File.read(rb_path),
      out: out,
    }
    File.write(res_path, data.to_json)
  end
end


$conf = Conf.new("config.yml")

rule ".mrb" => ".rb" do |t|
  sh "#{$conf.mrbc} -E '#{t.source}'"
end

# 
# basictest
#

BASIC_HEADER = File.read("test/basictest/header.rb")
BASIC_RBS = Dir["test/basictest/test_*.rb"]
BASIC_MRBS = BASIC_RBS.map{|s| s.sub(".rb", ".mrb")}
BASIC_RESULTS = BASIC_RBS.map{|s| s.sub(".rb", ".res")}
BASIC_REPORT = "report/basictest.html"

BASIC_RBS.zip(BASIC_MRBS, BASIC_RESULTS).each do |rb_path, mrb_path, res_path|
  file mrb_path => rb_path do
    Test.compile(BASIC_HEADER, rb_path, mrb_path)
  end

  file res_path => mrb_path do
    Test.run(rb_path, mrb_path, res_path)
  end
end

file BASIC_REPORT => [*BASIC_RESULTS,
                      "test/make_report.rb",
                      "test/test_report.html.erb"] do
  sh "ruby test/make_report.rb test/basictest/ > #{BASIC_REPORT}"
end

desc "run basictest"
task "basictest" => BASIC_REPORT

#
# bootstraptest
#

BOOTSTRAP_HEADER = File.read("test/bootstraptest/header.rb")
BOOTSTRAP_RBS = Dir["test/bootstraptest/test_*.rb"]
BOOTSTRAP_MRBS = BOOTSTRAP_RBS.map{|s| s.sub(".rb", ".mrb")}
BOOTSTRAP_RESULTS = BOOTSTRAP_RBS.map{|s| s.sub(".rb", ".res")}
BOOTSTRAP_REPORT = "report/bootstraptest.html"

BOOTSTRAP_RBS.zip(BOOTSTRAP_MRBS, BOOTSTRAP_RESULTS).each do |rb_path, mrb_path, res_path|
  file mrb_path => rb_path do
    Test.compile(BOOTSTRAP_HEADER, rb_path, mrb_path)
  end

  file res_path => mrb_path do
    Test.run(rb_path, mrb_path, res_path)
  end
end

file BOOTSTRAP_REPORT => [*BOOTSTRAP_RESULTS,
                          "test/make_report.rb",
                          "test/test_report.html.erb"] do
  sh "ruby test/make_report.rb test/bootstraptest/ > #{BOOTSTRAP_REPORT}"
end


desc "run bootstraptest"
task "bootstraptest" => BOOTSTRAP_REPORT

#
# mrubytest
#

MRUBY_RBS = Dir["test/mrubytest/test_*.rb"]
MRUBY_RESULTS = MRUBY_RBS.map{|s| s.sub(".rb", ".res")}
MRUBY_REPORT = "report/mrubytest.html"

MRUBY_RBS.zip(MRUBY_RESULTS).each do |rb_path, res_path|
  file res_path => rb_path do
    sh "ruby test/mrubytest/runner.rb #{rb_path} #{$conf.mruby_path} #{$conf.mrubyc_path} > #{res_path}"
  end
end

file MRUBY_REPORT => [*MRUBY_RESULTS,
                      "test/mrubytest/make_report.rb", 
                      "test/mrubytest/mruby_report.html.erb"] do
  sh "ruby test/mrubytest/make_report.rb > #{MRUBY_REPORT}"
end

desc "run mrubytest"
task "mrubytest" => MRUBY_REPORT

task default: ["basictest", "bootstraptest", "mrubytest"]
