test_check "while/until";

# test break
i = 0
while i < 10
  break if i == 3
  i += 1
end
test_ok(i == 3)

# test next
$bad = false
i = 0
while i < 10
  i += 1
  next if i == 3
  $bad = 1 if i == 3
end
test_ok(!$bad)

# test redo
sum = 0
i = 0
while i < 3
  sum += i
  redo if sum == 1
  i += 1
end
test_ok(sum == 4)

# test until
i = 0
until i>4
  i+=1
end
test_ok(i==5)

