def assert_true(given)
  if given
    puts "ok"
  else
    puts "ng"
  end
end

def assert_false(given)
  assert_true(!given)
end

def assert_equal(expected, given)
  assert_true(expected == given)
end

def assert_not_equal(expected, given)
  assert_true(expected != given)
end

def assert_nil(arg)
  assert_true(nil == arg)
end

def assert_raise(arg)
  # skip
end
