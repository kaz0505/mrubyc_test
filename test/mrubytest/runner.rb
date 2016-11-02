require 'tempfile'
require 'json'

if ARGV.size < 2
  raise "usage: #$0 MRUBY_PATH MRUBYC_PATH"
end
mruby_path, mrubyc_path = *ARGV

class Test < Struct.new(:rb_path, :title, :rb_txt, :out) 
  def to_json(_); to_h.to_json; end
end

tests = Hash.new{|h, k| h[k] = []}
Dir["#{__dir__}/test_*.rb"].each do |rb_path|
  category = File.basename(rb_path, ".rb")
  next if category =~ /(exception|superclass|module)\z/
  next if category =~ /(string)\z/

  title = rb = nil
  File.readlines(rb_path).each do |line|
    case line
    when /^assert\(['"](.+?)['"].+/
      raise "missing end" if title 
      title = $1
    when /^end/
      raise "missing start" unless title
      tests[category] << Test.new(rb_path, title, rb, nil)
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
end

header = File.read("#{__dir__}/header.rb")
tests.each do |category, ts|
  ts.each do |t|
    $stderr.puts("#{t.rb_path} #{t.title}")
    f1 = Tempfile.new(File.basename(t.rb_path))
    f1.write(header + t.rb_txt)
    f1.close
    f2 = Tempfile.new(File.basename(t.rb_path))
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
end

puts tests.to_json
