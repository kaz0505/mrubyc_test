$title = ""
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

def assert_not_equal(expected, given)
  if expected != given
    puts "ok: " + $title
  else
    puts "ng: " + $title
  end
end

def assert_true(given)
  if given
    puts "ok: " + $title
  else
    puts "ng: " + $title
  end
end
def assert_false(given); assert_true(!given); end

def assert_nil(arg)
  assert_true(nil == arg)
end
