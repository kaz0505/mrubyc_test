test_check "iterator1"

test_ok(!iterator?)

def ttt
  test_ok(iterator?)
end
ttt{}

# mrubyで通らない(defined?がない)
# yield at top level
#test_ok(!defined?(yield))

$x = [1, 2, 3, 4]
$y = []

# iterator over array
for i in $x
  $y.push i
end
test_ok($x == $y)

# nested iterator
def tt
  1.upto(10) {|i|
    yield i
  }
end

i=0
tt{|i| break if i == 5}
test_ok(i == 0)

def tt2(dummy)
  yield 1
end

def tt3(&block)
  tt2(raise(ArgumentError,""),&block)
end

$x = false
begin
  tt3{}
rescue ArgumentError
  $x = true
rescue Exception
end
test_ok($x)

def tt4 &block
  tt2(raise(ArgumentError,""),&block)
end
$x = false
begin
  tt4{}
rescue ArgumentError
  $x = true
rescue Exception
end
test_ok($x)

# iterator break/redo/next/retry
done = true
loop{
  break
  done = false			# should not reach here
}
test_ok(done)

done = false
$bad = false
loop {
  break if done
  done = true
  next
  $bad = true			# should not reach here
}
test_ok(!$bad)

done = false
$bad = false
loop {
  break if done
  done = true
  redo
  $bad = true			# should not reach here
}
test_ok(!$bad)

$x = []
for i in 1 .. 7
  $x.push i
end
test_ok($x.size == 7)
test_ok($x == [1, 2, 3, 4, 5, 6, 7])

