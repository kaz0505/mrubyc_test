$title = nil
def assert(title, section)
  $title = title
end

def assert_equal(expected, given)
  if expected == given
    puts "ok: " + $title
  else
    puts "ng: " + $title
  end
end

#
# mruby/test/t/array.rb
#

#assert('Array#+', '15.2.12.5.1') #do
#  assert_equal([1, 1], [1].+([1]))
#end

assert('Array#length', '15.2.12.5.19') #do
  a = [1,2,3]

  assert_equal(3, a.length)
#end

assert('Array#size', '15.2.12.5.28') #do
  a = [1,2,3]

  assert_equal(3, a.size)
#end
