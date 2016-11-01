test_check "iterator"

test_ok(!iterator?)

def ttt
  test_ok(iterator?)
end
ttt{}

# yield at top level
test_ok(!defined?(yield))

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

# append method to built-in class
class Array
  def iter_test1
    collect{|e| [e, yield(e)]}.sort{|a,b|a[1]<=>b[1]}
  end
  def iter_test2
    a = collect{|e| [e, yield(e)]}
    a.sort{|a,b|a[1]<=>b[1]}
  end
end
$x = [[1,2],[3,4],[5,6]]
test_ok($x.iter_test1{|x|x} == $x.iter_test2{|x|x})

class IterTest
  def initialize(e); @body = e; end

  def each0(&block); @body.each(&block); end
  def each1(&block); @body.each {|*x| block.call(*x) } end
  def each2(&block); @body.each {|*x| block.call(x) } end
  def each3(&block); @body.each {|x| block.call(*x) } end
  def each4(&block); @body.each {|x| block.call(x) } end
  def each5; @body.each {|*x| yield(*x) } end
  def each6; @body.each {|*x| yield(x) } end
  def each7; @body.each {|x| yield(*x) } end
  def each8; @body.each {|x| yield(x) } end

  def f(a)
    a
  end
end
test_ok(IterTest.new(nil).method(:f).to_proc.call([1]) == [1])
m = /\w+/.match("abc")
test_ok(IterTest.new(nil).method(:f).to_proc.call([m]) == [m])

IterTest.new([0]).each0 {|x| test_ok(x == 0)}
IterTest.new([1]).each1 {|x| test_ok(x == 1)}
IterTest.new([2]).each2 {|x| test_ok(x == [2])}
#IterTest.new([3]).each3 {|x| test_ok(x == 3)}
IterTest.new([4]).each4 {|x| test_ok(x == 4)}
IterTest.new([5]).each5 {|x| test_ok(x == 5)}
IterTest.new([6]).each6 {|x| test_ok(x == [6])}
#IterTest.new([7]).each7 {|x| test_ok(x == 7)}
IterTest.new([8]).each8 {|x| test_ok(x == 8)}

IterTest.new([[0]]).each0 {|x| test_ok(x == [0])}
IterTest.new([[1]]).each1 {|x| test_ok(x == [1])}
IterTest.new([[2]]).each2 {|x| test_ok(x == [[2]])}
IterTest.new([[3]]).each3 {|x| test_ok(x == 3)}
IterTest.new([[4]]).each4 {|x| test_ok(x == [4])}
IterTest.new([[5]]).each5 {|x| test_ok(x == [5])}
IterTest.new([[6]]).each6 {|x| test_ok(x == [[6]])}
IterTest.new([[7]]).each7 {|x| test_ok(x == 7)}
IterTest.new([[8]]).each8 {|x| test_ok(x == [8])}

IterTest.new([[0,0]]).each0 {|*x| test_ok(x == [[0,0]])}
IterTest.new([[8,8]]).each8 {|*x| test_ok(x == [[8,8]])}

def m0(v)
  v
end

def m1
  m0(block_given?)
end
test_ok(m1{p 'test'})
test_ok(!m1)

def m
  m0(block_given?,&Proc.new{})
end
test_ok(m1{p 'test'})
test_ok(!m1)

class C
  include Enumerable
  def initialize
    @a = [1,2,3]
  end
  def each(&block)
    @a.each(&block)
  end
end

test_ok(C.new.collect{|n| n} == [1,2,3])

test_ok(Proc == lambda{}.class)
test_ok(Proc == Proc.new{}.class)
lambda{|a|test_ok(a==1)}.call(1)
def block_test(klass, &block)
  test_ok(klass === block)
end

block_test(NilClass)
block_test(Proc){}

def call_argument_test(state, proc, *args)
  x = state
  begin
    proc.call(*args)
  rescue ArgumentError
    x = !x
  end
  test_ok(x,2)
end

call_argument_test(true, lambda{||})
call_argument_test(false, lambda{||}, 1)
call_argument_test(true, lambda{|a,|}, 1)
call_argument_test(false, lambda{|a,|})
call_argument_test(false, lambda{|a,|}, 1,2)

call_argument_test(true, Proc.new{||})
call_argument_test(true, Proc.new{||}, 1)
call_argument_test(true, Proc.new{|a,|}, 1)
call_argument_test(true, Proc.new{|a,|})
call_argument_test(true, Proc.new{|a,|}, 1,2)

def block_get(&block)
  block
end

test_ok(Proc == block_get{}.class)
call_argument_test(true, block_get{||})
call_argument_test(true, block_get{||}, 1)
call_argument_test(true, block_get{|a,|}, 1)
call_argument_test(true, block_get{|a,|})
call_argument_test(true, block_get{|a,|}, 1,2)

call_argument_test(true, block_get(&lambda{||}))
call_argument_test(false, block_get(&lambda{||}),1)
call_argument_test(true, block_get(&lambda{|a,|}),1)
call_argument_test(false, block_get(&lambda{|a,|}),1,2)

blk = block_get{11}
test_ok(blk.class == Proc)
test_ok(blk.to_proc.class == Proc)
test_ok(blk.clone.call == 11)
test_ok(block_get(&blk).class == Proc)

lmd = lambda{44}
test_ok(lmd.class == Proc)
test_ok(lmd.to_proc.class == Proc)
test_ok(lmd.clone.call == 44)
test_ok(block_get(&lmd).class == Proc)

test_ok(Proc.new{|a,| a}.yield(1,2,3) == 1)
call_argument_test(true, Proc.new{|a,|}, 1,2)

test_ok(Proc.new{|&b| b.call(10)}.call {|x| x} == 10)
test_ok(Proc.new{|a,&b| b.call(a)}.call(12) {|x| x} == 12)

def test_return1
  Proc.new {
    return 55
  }.yield + 5
end
test_ok(test_return1() == 55)
def test_return2
  lambda {
    return 55
  }.call + 5
end
test_ok(test_return2() == 60)

def proc_call(&b)
  b.call
end
def proc_yield()
  yield
end
def proc_return1
  lambda{return 42}.call+1
end
test_ok(proc_return1() == 43)
def proc_return2
  ->{return 42}.call+1
end
test_ok(proc_return2() == 43)
def proc_return3
  proc_call{return 42}+1
end
test_ok(proc_return3() == 42)
def proc_return4
  proc_yield{return 42}+1
end
test_ok(proc_return4() == 42)

def ljump_test(state, proc, *args)
  x = state
  begin
    proc.call(*args)
  rescue LocalJumpError
    x = !x
  end
  test_ok(x,2)
end

ljump_test(false, block_get{break})
ljump_test(true, lambda{break})

def exit_value_test(&block)
  block.call
rescue LocalJumpError
  $!.exit_value
end

test_ok(45 == exit_value_test{break 45})

test_ok(55 == begin
              block_get{break 55}.call
            rescue LocalJumpError
              $!.exit_value
            end)

def block_call(&block)
  block.call
end

def test_b1
  block_call{break 11}
end
test_ok(test_b1() == 11)

def ljump_rescue(r)
  begin
    yield
  rescue LocalJumpError => e
    r if /from proc-closure/ =~ e.message
  end
end

def test_b2
  ljump_rescue(22) do
    block_get{break 21}.call
  end
end
test_ok(test_b2() == 22)

def test_b3
  ljump_rescue(33) do
    Proc.new{break 31}.yield
  end
end
test_ok(test_b3() == 33)

def test_b4
  lambda{break 44}.call
end
test_ok(test_b4() == 44)

def test_b5
  ljump_rescue(55) do
    b = block_get{break 54}
    block_call(&b)
  end
end
test_ok(test_b5() == 55)

def test_b6
  b = lambda{break 67}
  block_call(&b)
  66
end
test_ok(test_b6() == 66)

def util_r7
  block_get{break 78}
end

def test_b7
  b = util_r7()
  ljump_rescue(77) do
    block_call(&b)
  end
end
test_ok(test_b7() == 77)

def util_b8(&block)
  block_call(&block)
end

def test_b8
  util_b8{break 88}
end
test_ok(test_b8() == 88)

def util_b9(&block)
  lambda{block.call; 98}.call
end

def test_b9
  util_b9{break 99}
end
test_ok(test_b9() == 99)

def util_b10
  util_b9{break 100}
end

def test_b10
  util_b10()
end
test_ok(test_b10() == 100)

def test_b11
  ljump_rescue(111) do
    loop do
      Proc.new{break 110}.yield
      break 112
    end
  end
end
test_ok(test_b11() == 111)

def test_b12
  loop do
    break lambda{break 122}.call
    break 121
  end
end
test_ok(test_b12() == 122)

def test_b13
  ljump_rescue(133) do
    while true
      Proc.new{break 130}.yield
      break 131
    end
  end
end
test_ok(test_b13() == 133)

def test_b14
  while true
    break lambda{break 144}.call
    break 143
  end
end
test_ok(test_b14() == 144)

def test_b15
  [0].each {|c| yield 1 }
  156
end
test_ok(test_b15{|e| break 155 } == 155)

def marity_test(m)
  method = method(m)
  test_ok(method.arity == method.to_proc.arity, 2)
end
marity_test(:test_ok)
marity_test(:marity_test)
marity_test(:p)

lambda(&method(:test_ok)).call(true)
lambda(&block_get{|a,n| test_ok(a,n)}).call(true, 2)

class ITER_TEST1
   def a
     block_given?
   end
end

class ITER_TEST2 < ITER_TEST1
   def a
     test_ok(super)
     super
   end
end
test_ok(ITER_TEST2.new.a {})

class ITER_TEST3
  def foo x
    return yield if block_given?
    x
  end
end

class ITER_TEST4 < ITER_TEST3
  def foo x
    test_ok(super == yield)
    test_ok(super(x, &nil) == x)
  end
end

ITER_TEST4.new.foo(44){55}

class ITER_TEST5
   def tt(aa)
     aa
   end

   def uu(a)
      class << self
         define_method(:tt) do |sym|
            super(sym)
         end
      end
   end

   def xx(*x)
     x.size
   end
end

a = ITER_TEST5.new
a.uu(12)
test_ok(a.tt(1) == 1)

class ITER_TEST6 < ITER_TEST5
   def xx(*a)
      a << 12
      super
   end
end

test_ok(ITER_TEST6.new.xx([24]) == 2)


