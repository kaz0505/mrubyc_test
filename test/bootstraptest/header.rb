def assert_equal(expected_str, given_value)
  if given_value.to_s == expected_str
    puts "ok"
  else
    puts "ng: " + expected_str
  end
end

def assert_normal_exit(given_value)
  puts "ok"
end
