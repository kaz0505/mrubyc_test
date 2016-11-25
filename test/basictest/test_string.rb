test_check "string & char"

test_ok("abcd" == "abcd")
test_ok("abcd" === "abcd")

$foo = "abc"
test_ok("#{$foo} = abc" == "abc = abc")

foo = "abc"
test_ok("#{foo} = abc" == "abc = abc")

test_ok('-' * 5 == '-----')
test_ok('-' * 1 == '-')
test_ok('-' * 0 == '')

foo = '-'
test_ok(foo * 5 == '-----')
test_ok(foo * 1 == '-')
test_ok(foo * 0 == '')

# character constants(assumes ASCII)
test_ok("a"[0] == ?a)
test_ok(?a == ?a)
test_ok(?\C-a == "\1")
test_ok(?\M-a == "\341")
test_ok(?\M-\C-a == "\201")
test_ok("a".upcase![0] == ?A)
test_ok("A".downcase![0] == ?a)

$x = "abcdef"
$y = [ ?a, ?b, ?c, ?d, ?e, ?f ]
$bad = false
$x.each_byte {|i|
  if i.chr != $y.shift
    $bad = true
    break
  end
}
test_ok(!$bad)

s = <<EOS
#{
[1,2,3].join(",")
}
EOS
test_ok(s == "1,2,3\n")
test_ok("Just".to_i(36) == 926381)
test_ok(1299022.to_s(36) == "ruby")
test_ok(-1045307475.to_s(36) == "-hacker")
