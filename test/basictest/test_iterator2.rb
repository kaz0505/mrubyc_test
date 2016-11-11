test_check "iterator2"

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

# mrubyで動かない(methodがない)
#test_ok(IterTest.new(nil).method(:f).to_proc.call([1]) == [1])
#m = /\w+/.match("abc")
#test_ok(IterTest.new(nil).method(:f).to_proc.call([m]) == [m])

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
