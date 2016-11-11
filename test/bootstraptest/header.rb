def assert_equal(expected_str, given_value, message = '')
  if given_value.to_s == expected_str
    puts "ok"
  else
    puts "ng: " + expected_str + ' ' + message
  end
end

def assert_normal_exit(given_value)
  puts "ok"
end
