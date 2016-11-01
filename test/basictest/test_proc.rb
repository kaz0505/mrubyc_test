test_check "proc"
$proc = Proc.new{|i| i}
test_ok($proc.call(2) == 2)
test_ok($proc.call(3) == 3)

$proc = Proc.new{|i| i*2}
test_ok($proc.call(2) == 4)
test_ok($proc.call(3) == 6)

Proc.new{
  iii=5				# nested local variable
  $proc = Proc.new{|i|
    iii = i
  }
  $proc2 = Proc.new {
    $x = iii			# nested variables shared by procs
  }
  # scope of nested variables
  test_ok(defined?(iii))
}.call
test_ok(!defined?(iii))		# out of scope

loop{iii=5; test_ok(eval("defined? iii")); break}
loop {
  iii = 10
  def dyna_var_check
    loop {
      test_ok(!defined?(iii))
      break
    }
  end
  dyna_var_check
  break
}
$x=0
$proc.call(5)
$proc2.call
test_ok($x == 5)


