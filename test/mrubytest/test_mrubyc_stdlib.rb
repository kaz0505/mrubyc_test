assert('Array#==', '15.2.12.5.33') do
  assert_false(["a", "c"] == ["a", "c", 7])
  assert_true(["a", "c", 7] == ["a", "c", 7])
  assert_false(["a", "c", 7] == ["a", "d", "f"])
end

assert('Array#length', '15.2.12.5.19') do
  a = [1,2,3]

  assert_equal(3, a.length)
end

assert('Array#size', '15.2.12.5.28') do
  a = [1,2,3]

  assert_equal(3, a.size)
end

assert('Array#+', '15.2.12.5.1') do
  assert_equal([1, 1], [1].+([1]))
end

assert('Array#empty?', '15.2.12.5.12') do
  a = []
  b = [b]
  assert_true([].empty?)
  assert_false([1].empty?)
end

assert('Array#[]', '15.2.12.5.4') do
  a = Array.new
  assert_raise(ArgumentError) do
    # this will cause an exception due to the wrong arguments
    a.[]()
  end
  assert_raise(ArgumentError) do
    # this will cause an exception due to the wrong arguments
    a.[](1,2,3)
  end

  assert_equal(2, [1,2,3].[](1))
  assert_equal(nil, [1,2,3].[](4))
  assert_equal(3, [1,2,3].[](-1))
  assert_equal(nil, [1,2,3].[](-4))

  a = [ "a", "b", "c", "d", "e" ]
  assert_equal("b", a[1.1])
  assert_equal(["b", "c"], a[1,2])
  assert_equal(["b", "c", "d"], a[1..-2])
end

assert('Array#[]=', '15.2.12.5.5') do
  a = Array.new
  assert_raise(ArgumentError) do
    # this will cause an exception due to the wrong arguments
    a.[]=()
  end
  assert_raise(ArgumentError) do
    # this will cause an exception due to the wrong arguments
    a.[]=(1,2,3,4)
  end
  assert_raise(IndexError) do
    # this will cause an exception due to the wrong arguments
    a = [1,2,3,4,5]
    a[1, -1] = 10
  end

  assert_equal(4, [1,2,3].[]=(1,4))
  assert_equal(3, [1,2,3].[]=(1,2,3))

  a = [1,2,3,4,5]
  a[3..-1] = 6
  assert_equal([1,2,3,6], a)

  a = [1,2,3,4,5]
  a[3..-1] = []
  assert_equal([1,2,3], a)

  a = [1,2,3,4,5]
  a[2...4] = 6
  assert_equal([1,2,6,5], a)
end

assert('Array#index', '15.2.12.5.14') do
  a = [1,2,3]

  assert_equal(1, a.index(2))
  assert_equal(nil, a.index(0))
end

assert('Array#last', '15.2.12.5.18') do
  assert_raise(ArgumentError) do
    # this will cause an exception due to the wrong argument
    [1,2,3].last(-1)
  end

  a = [1,2,3]
  assert_equal(3, a.last)
  assert_nil([].last)
end

assert('Array#pop', '15.2.12.5.21') do
  a = [1,2,3]
  b = a.pop

  assert_nil([].pop)
  assert_equal([1,2], a)
  assert_equal(3, b)
end

assert('Integer#==', '15.2.8.3.7') do
  a = 1==0
  b = 1==1

  assert_false a
  assert_true b
end

assert('Integer#%', '15.2.8.3.5') do
  a = 1%1
  b = 1%1.0
  c = 2%4
  d = 2%5
  e = 2%-5
  f = -2%5
  g = -2%-5
  h =  2%-2
  i = -2%2
  j = -2%-2

  assert_equal 0, a
  assert_equal 0.0, b
  assert_equal 2, c
  assert_equal 2, d
  assert_equal(-3, e)
  assert_equal 3, f
  assert_equal(-2, g)
  assert_equal 0, h
  assert_equal 0, i
  assert_equal 0, j
end

assert('Integer#<<', '15.2.8.3.12') do
  # Left Shift by one
  #   00010111 (23)
  # = 00101110 (46)
  assert_equal 46, 23 << 1

  # Left Shift by a negative is Right Shift
  assert_equal 23, 46 << -1

  # Left Shift by 31 is bitShift overflow to SignedInt
  assert_equal 2147483648, 1 << 31

  # -3 Left Shift by 30 is bitShift overflow to SignedInt
  assert_equal(-3221225472, -3 << 30)
end

assert('Integer#>>', '15.2.8.3.13') do
  # Right Shift by one
  #   00101110 (46)
  # = 00010111 (23)
  assert_equal 23, 46 >> 1

  # Right Shift by a negative is Left Shift
  assert_equal 46, 23 >> -1

  # Don't raise on large Right Shift
  assert_equal 0, 23 >> 128
end

assert('Integer#to_s', '15.2.8.3.25') do
  assert_equal '1', 1.to_s
  assert_equal("-1", -1.to_s)
end

assert('String#size', '15.2.10.5.33') do
  assert_equal 3, 'abc'.size
end

assert('String#size(UTF-8)', '15.2.10.5.33') do
  str = 'こんにちは世界!'
  assert_equal 8, str.size
  assert_not_equal str.bytesize, str.size
  assert_equal 2, str[1, 2].size
end

assert('String#length', '15.2.10.5.26') do
  assert_equal 3, 'abc'.length
end

assert('String#==', '15.2.10.5.2') do
  assert_equal 'abc', 'abc'
  assert_not_equal 'abc', 'cba'
end

assert('String#to_i', '15.2.10.5.39') do
  a = ''.to_i
  b = '32143'.to_i
  c = 'a'.to_i(16)
  d = '100'.to_i(2)
  e = '1_000'.to_i

  assert_equal 0, a
  assert_equal 32143, b
  assert_equal 10, c
  assert_equal 4, d
  assert_equal 1_000, e
end
