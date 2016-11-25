#!/usr/bin/env ruby
require 'tempfile'
require 'test/unit'

# Path to mrbc
MRBC = "mrbc"
# Path to mrubyc
MRUBYC = "#{__dir__}/../sample_c/mrubyc"

#
# Test helpers
#
class Test::Unit::TestCase
  # Assert that mruby/c prints +expected_out+ when 
  # given +program_txt+ as a ruby script
  def assert_output(expected_out, program_txt)
    rb_file = Tempfile.new
    rb_file.write(program_txt)
    rb_file.close
    mrb_file = Tempfile.new
    mrb_file.close

    system "#{MRBC} -E -o #{mrb_file.path} #{rb_file.path}"
    out = `#{MRUBYC} #{mrb_file.path} 2>&1`
    assert_equal expected_out, out
  end
end

exit Test::Unit::AutoRunner.run(true, __dir__)
