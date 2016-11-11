test_check "iterator4"

def block_get(&block)
  block
end

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

#mrubyで通らない
#def ljump_test(state, proc, *args)
#  x = state
#  begin
#    proc.call(*args)
#  rescue LocalJumpError
#    x = !x
#  end
#  test_ok(x,2)
#end
#
#ljump_test(false, block_get{break})
#ljump_test(true, lambda{break})

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
    r if e.message.include?("from proc-closure")
  end
end

#mrubyで通らない
#def test_b2
#  ljump_rescue(22) do
#    block_get{break 21}.call
#  end
#end
#test_ok(test_b2() == 22)
#
#def test_b3
#  ljump_rescue(33) do
#    Proc.new{break 31}.yield
#  end
#end
#test_ok(test_b3() == 33)

def test_b4
  lambda{break 44}.call
end
test_ok(test_b4() == 44)

#def test_b5
#  ljump_rescue(55) do
#    b = block_get{break 54}
#    block_call(&b)
#  end
#end
#test_ok(test_b5() == 55)

def test_b6
  b = lambda{break 67}
  block_call(&b)
  66
end
test_ok(test_b6() == 66)

def util_r7
  block_get{break 78}
end

#def test_b7
#  b = util_r7()
#  ljump_rescue(77) do
#    block_call(&b)
#  end
#end
#test_ok(test_b7() == 77)

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

#def test_b11
#  ljump_rescue(111) do
#    loop do
#      Proc.new{break 110}.yield
#      break 112
#    end
#  end
#end
#test_ok(test_b11() == 111)

def test_b12
  loop do
    break lambda{break 122}.call
    break 121
  end
end
test_ok(test_b12() == 122)

#def test_b13
#  ljump_rescue(133) do
#    while true
#      Proc.new{break 130}.yield
#      break 131
#    end
#  end
#end
#test_ok(test_b13() == 133)

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

#mrubyではmethodがない
#def marity_test(m)
#  method = method(m)
#  test_ok(method.arity == method.to_proc.arity, 2)
#end
#marity_test(:test_ok)
#marity_test(:marity_test)
#marity_test(:p)
#lambda(&method(:test_ok)).call(true)
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
