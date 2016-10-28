require 'yaml'

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

# 
# basictest
#

file "test/basictest.mrb" => "test/basictest.rb" do
  sh "#{$conf.mrbc} -E test/basictest.rb"
end

desc "run basictest"
task "basictest" => "test/basictest.mrb" do
  sh "#{$conf.mrubyc} test/basictest.mrb | tee report/basictest.txt"
end

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
