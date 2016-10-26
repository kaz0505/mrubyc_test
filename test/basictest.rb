$testnum=0
$failed = 0

def test_check(what)
  puts what
  $what = what
  $testnum = 0
end

def test_ok(cond, n=1)
  $testnum += 1
  if cond
    puts "ok " + $testnum.to_s
  else
    puts "not ok " + $what + " " + $testnum.to_s
    $failed += 1
  end
end

test_check "assignment"

aa = 5
aa ||= 25
test_ok(aa == 5)
bb ||= 25
test_ok(bb == 25)
cc &&=33
test_ok(cc == nil)
cc = 5
cc &&=44
test_ok(cc == 44)
