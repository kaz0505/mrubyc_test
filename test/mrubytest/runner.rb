require 'tempfile'
require 'json'

if ARGV.size < 3
  raise "usage: #$0 RB_PATH MRUBY_PATH MRUBYC_PATH"
end
rb_path, mruby_path, mrubyc_path = *ARGV

class TestCase < Struct.new(:title, :rb_txt, :out) 
  def to_json(_); to_h.to_json; end
end

cases = []
title = rb = nil
File.readlines(rb_path).each do |line|
  case line
  when /^assert\(['"](.+?)['"].+/
    raise "missing end" if title 
    title = $1
  when /^end/
    raise "missing start" unless title
    cases << TestCase.new(title, rb, nil)
    title = rb = nil
  when /^\s*$/
    # skip
  when /^#/
    # skip
  else
    raise "unknown line out of test: #{line.inspect} in #{rb_path}" unless title
    rb ||= ""
    rb << line
  end
end

header = File.read("#{__dir__}/header.rb")
cases.each do |t|
  f1 = Tempfile.new(File.basename(rb_path))
  f1.write(header + t.rb_txt)
  f1.close
  f2 = Tempfile.new(File.basename(rb_path))
  f2.close
  system "#{mruby_path}/bin/mrbc -E -o #{f2.path} #{f1.path}"
  t.out = `#{mrubyc_path}/sample_c/mrubyc #{f2.path} 2>&1`
  if $?.exitstatus == 139
    if File.exist?("core")
      t.out << `gdb -batch -c core -ex bt`
    else
      puts "Detected SEGV but core file not found"
    end
  end
end

cat = File.basename(rb_path)
puts({rb_path: rb_path, category: cat, cases: cases}.to_json)
