require 'yaml'
require 'tempfile'

class Conf
  def initialize(path)
    @yaml = YAML.load_file(path)
  end

  def mruby_path; File.expand_path(@yaml[:mruby_path]); end
  def mrubyc_path; File.expand_path(@yaml[:mrubyc_path]); end

  def mrbc; File.join(mruby_path, "bin/mrbc"); end
  def mrubyc; File.join(mrubyc_path, "sample_c/mrubyc"); end
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
    f = Tempfile.new(File.basename(rb_path))
    f.write(BASIC_HEADER + File.read(rb_path))
    f.close
    sh "#{$conf.mrbc} -E -o #{mrb_path} #{f.path}"
  end

  file out_path => mrb_path do
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

file BASIC_REPORT => [*BASIC_OUTS,
                      "test/basictest/make_report.rb",
                      "test/basictest/basic_report.html.erb"] do
  sh "ruby test/basictest/make_report.rb > #{BASIC_REPORT}"
end

desc "run basictest"
task "basictest" => BASIC_REPORT

#
# bootstraptest
#

desc "run bootstraptest"
task "bootstraptest" do
  # TBA
end

#
# mrubytest
#

file "test/mrubytest.mrb" => "test/mrubytest.rb" do
  sh "#{$conf.mrbc} -E test/mrubytest.rb"
end

desc "run mrubytest"
task "mrubytest" => "test/mrubytest.mrb" do
  sh "#{$conf.mrubyc} test/mrubytest.mrb | tee report/mrubytest.txt"
end

task default: ["basictest", "bootstraptest", "mrubytest"]
