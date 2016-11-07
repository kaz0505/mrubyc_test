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

  def self.compile(rb_path, mrb_path)
    f = Tempfile.new(File.basename(rb_path))
    f.write(BASIC_HEADER + File.read(rb_path))
    f.close
    sh "#{$conf.mrbc} -E -o #{mrb_path} #{f.path}"
  end

  def self.run(mrb_path, out_path)
    cmd = "#{$conf.mrubyc} #{mrb_path} > #{out_path} 2>&1"
    puts cmd
    p system cmd
    if $?.exitstatus == 139
      if File.exist?("core")
        sh "gdb -batch -c core -ex bt >> #{out_path}"
      else
        puts "Detected SEGV but core file not found"
      end
    end
    puts File.read(out_path)
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
BASIC_OUTS = BASIC_RBS.map{|s| s.sub(".rb", ".out")}
BASIC_REPORT = "report/basictest.html"

BASIC_RBS.zip(BASIC_MRBS, BASIC_OUTS).each do |rb_path, mrb_path, out_path|
  file mrb_path => rb_path do
    Test.compile(rb_path, mrb_path)
  end

  file out_path => mrb_path do
    Test.run(mrb_path, out_path)
  end
end

file BASIC_REPORT => [*BASIC_OUTS,
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
BOOTSTRAP_OUTS = BOOTSTRAP_RBS.map{|s| s.sub(".rb", ".out")}
BOOTSTRAP_REPORT = "report/bootstraptest.html"

BOOTSTRAP_RBS.zip(BOOTSTRAP_MRBS, BOOTSTRAP_OUTS).each do |rb_path, mrb_path, out_path|
  file mrb_path => rb_path do
    Test.compile(rb_path, mrb_path)
  end

  file out_path => mrb_path do
    Test.run(mrb_path, out_path)
  end
end

file BOOTSTRAP_REPORT => [*BOOTSTRAP_OUTS,
                          "test/make_report.rb",
                          "test/test_report.html.erb"] do
  sh "ruby test/make_report.rb test/bootstraptest/ > #{BOOTSTRAP_REPORT}"
end


desc "run bootstraptest"
task "bootstraptest" => BOOTSTRAP_REPORT

#
# mrubytest
#

MRUBY_OUT = "test/mrubytest/mrubytest.json"
MRUBY_REPORT = "report/mrubytest.html"

file MRUBY_OUT => "test/mrubytest/runner.rb" do
  sh "ruby test/mrubytest/runner.rb #{$conf.mruby_path} #{$conf.mrubyc_path} > #{MRUBY_OUT}"
end

file MRUBY_REPORT => [MRUBY_OUT,
                      "test/mrubytest/make_report.rb", 
                      "test/mrubytest/mruby_report.html.erb"] do
  sh "ruby test/mrubytest/make_report.rb > #{MRUBY_REPORT}"
end

desc "run mrubytest"
task "mrubytest" => MRUBY_REPORT

task default: ["basictest", "bootstraptest", "mrubytest"]
