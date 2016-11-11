test_check "hash"
$x = {1=>2, 2=>4, 3=>6}

test_ok($x[1] == 2)

test_ok(begin
     for k,v in $x
       raise if k*2 != v
     end
     true
   rescue
     false
   end)

test_ok($x.length == 3)
test_ok($x.has_key?(1))
test_ok($x.has_value?(4))
test_ok($x.values_at(2,3) == [4,6])
test_ok($x == {1=>2, 2=>4, 3=>6})

$z = $x.keys.sort.join(":")
test_ok($z == "1:2:3")

$z = $x.values.sort.join(":")
test_ok($z == "2:4:6")
test_ok($x == $x)

$x.shift
test_ok($x.length == 2)

$z = [1,2]
$x[$z] = 256
test_ok($x[$z] == 256)

$x = Hash.new(0)
$x[1] = 1
test_ok($x[1] == 1)
test_ok($x[2] == 0)

$x = Hash.new([])
test_ok($x[22] == [])
test_ok($x[22].equal?($x[22]))

$x = Hash.new{[]}
test_ok($x[22] == [])
test_ok(!$x[22].equal?($x[22]))

$x = Hash.new{|h,k| $z = k; h[k] = k*2}
$z = 0
test_ok($x[22] == 44)
test_ok($z == 22)
$z = 0
test_ok($x[22] == 44)
test_ok($z == 0)
$x.default = 5
test_ok($x[23] == 5)

# mrubyで通らない
#$x = Hash.new
#def $x.default(k)
#  $z = k
#  self[k] = k*2
#end
#$z = 0
#test_ok($x[22] == 44)
#test_ok($z == 22)
#$z = 0
#test_ok($x[22] == 44)
#test_ok($z == 0)
