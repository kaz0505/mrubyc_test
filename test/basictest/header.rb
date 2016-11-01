$testnum=0
$failed = 0

def test_check(what)
  puts "-- " + what
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

def test_nok(cond)
  cond ? test_ok(false) : test_ok(true)
end
