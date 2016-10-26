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

file "test/basictest.mrb" => "test/basictest.rb" do
  sh "#{$conf.mrbc} -E test/basictest.rb"
end

desc "run basictest"
task "basictest" => "test/basictest.mrb" do
  sh "#{$conf.mrubyc} test/basictest.mrb"
end

desc "run bootstraptest"
task "bootstraptest" do
  # TBA
end

desc "run mrubytest"
task "mrubytest" do
  # TBA
end

task default: ["basictest", "bootstraptest", "mrubytest"]
