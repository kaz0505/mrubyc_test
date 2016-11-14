test_check "while/until";

# test break
tmp = ["tvi925", "tvi920", "vt100", "Amiga", "paper"]
while line = tmp.shift
  break if line == "vt100"
end

test_ok(line == "vt100")

# test next
$bad = false
tmp = ["tvi925", "tvi920", "vt100", "Amiga", "paper"]
while line = tmp.shift
  next if line == "vt100"
  $bad = 1 if line =="vt100"
end
test_ok(!(line == "vt100" || $bad))

# test redo
sum=0
for i in 1..10
  sum += i
  i -= 1
  if i > 0
    redo
  end
end
test_ok(sum == 220)

# test until
i = 0
until i>4
  i+=1
end
test_ok(i==5)

