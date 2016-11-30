a,=*[1]
test_ok(a == 1)
a,=*[[1]]
test_ok(a == [1])
a,=*[[[1]]]
test_ok(a == [[1]])

x, (y, z) = 1, 2, 3
test_ok([1,2,nil] == [x,y,z])
x, (y, z) = 1, [2,3]
test_ok([1,2,3] == [x,y,z])
x, (y, z) = 1, [2]
test_ok([1,2,nil] == [x,y,z])

#a = loop do break; end; test_ok(a == nil)
#a = loop do break nil; end; test_ok(a == nil)
#a = loop do break 1; end; test_ok(a == 1)
#a = loop do break []; end; test_ok(a == [])
#a = loop do break [1]; end; test_ok(a == [1])
#a = loop do break [nil]; end; test_ok(a == [nil])
#a = loop do break [[]]; end; test_ok(a == [[]])
#a = loop do break [*[]]; end; test_ok(a == [])
#a = loop do break [*[1]]; end; test_ok(a == [1])
#a = loop do break [*[1,2]]; end; test_ok(a == [1,2])
#
#a = loop do break *[]; end; test_ok(a == [])
#a = loop do break *[1]; end; test_ok(a == [1])
#a = loop do break *[nil]; end; test_ok(a == [nil])
#a = loop do break *[[]]; end; test_ok(a == [[]])
#a = loop do break *[*[]]; end; test_ok(a == [])
#a = loop do break *[*[1]]; end; test_ok(a == [1])
#a = loop do break *[*[1,2]]; end; test_ok(a == [1,2])
#
#*a = loop do break; end; test_ok(a == [nil])
#*a = loop do break nil; end; test_ok(a == [nil])
#*a = loop do break 1; end; test_ok(a == [1])
#*a = loop do break []; end; test_ok(a == [])
#*a = loop do break [1]; end; test_ok(a == [1])
#*a = loop do break [nil]; end; test_ok(a == [nil])
#*a = loop do break [[]]; end; test_ok(a == [[]])
#*a = loop do break [1,2]; end; test_ok(a == [1,2])
#*a = loop do break [*[]]; end; test_ok(a == [])
#*a = loop do break [*[1]]; end; test_ok(a == [1])
#*a = loop do break [*[1,2]]; end; test_ok(a == [1,2])
#
#*a = loop do break *[]; end; test_ok(a == [])
#*a = loop do break *[1]; end; test_ok(a == [1])
#*a = loop do break *[nil]; end; test_ok(a == [nil])
#*a = loop do break *[[]]; end; test_ok(a == [[]])
#*a = loop do break *[1,2]; end; test_ok(a == [1,2])
#*a = loop do break *[*[]]; end; test_ok(a == [])
#*a = loop do break *[*[1]]; end; test_ok(a == [1])
#*a = loop do break *[*[1,2]]; end; test_ok(a == [1,2])
#
#*a = *loop do break *[[]]; end; test_ok(a == [[]])
#*a = *loop do break *[1,2]; end; test_ok(a == [1,2])
#*a = *loop do break *[*[1,2]]; end; test_ok(a == [1,2])
#
#a,b,*c = loop do break; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break nil; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break 1; end; test_ok([a,b,c] == [1,nil,[]])
#a,b,*c = loop do break []; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break [1]; end; test_ok([a,b,c] == [1,nil,[]])
#a,b,*c = loop do break [nil]; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break [[]]; end; test_ok([a,b,c] == [[],nil,[]])
#a,b,*c = loop do break [1,2]; end; test_ok([a,b,c] == [1,2,[]])
#a,b,*c = loop do break [*[]]; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break [*[1]]; end; test_ok([a,b,c] == [1,nil,[]])
#a,b,*c = loop do break [*[1,2]]; end; test_ok([a,b,c] == [1,2,[]])
#
#a,b,*c = loop do break *[]; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break *[1]; end; test_ok([a,b,c] == [1,nil,[]])
#a,b,*c = loop do break *[nil]; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break *[[]]; end; test_ok([a,b,c] == [[],nil,[]])
#a,b,*c = loop do break *[1,2]; end; test_ok([a,b,c] == [1,2,[]])
#a,b,*c = loop do break *[*[]]; end; test_ok([a,b,c] == [nil,nil,[]])
#a,b,*c = loop do break *[*[1]]; end; test_ok([a,b,c] == [1,nil,[]])
#a,b,*c = loop do break *[*[1,2]]; end; test_ok([a,b,c] == [1,2,[]])

#def r(val); a = yield(); test_ok(a == val, 2); end
#r(nil){next}
#r(nil){next nil}
#r(1){next 1}
#r([]){next []}
#r([1]){next [1]}
#r([nil]){next [nil]}
#r([[]]){next [[]]}
#r([]){next [*[]]}
#r([1]){next [*[1]]}
#r([1,2]){next [*[1,2]]}
#
#r([]){next *[]}
#r([1]){next *[1]}
#r([nil]){next *[nil]}
#r([[]]){next *[[]]}
#r([]){next *[*[]]}
#r([1]){next *[*[1]]}
#r([1,2]){next *[*[1,2]]}
#
#def r(val); *a = yield(); test_ok(a == val, 2); end
#r([nil]){next}
#r([nil]){next nil}
#r([1]){next 1}
#r([]){next []}
#r([1]){next [1]}
#r([nil]){next [nil]}
#r([[]]){next [[]]}
#r([1,2]){next [1,2]}
#r([]){next [*[]]}
#r([1]){next [*[1]]}
#r([1,2]){next [*[1,2]]}
#
#def r(val); *a = *yield(); test_ok(a == val, 2); end
#r([[]]){next *[[]]}
#r([1,2]){next *[1,2]}
#r([1,2]){next *[*[1,2]]}
#
#def r(val); a,b,*c = yield(); test_ok([a,b,c] == val, 2); end
#r([nil,nil,[]]){next}
#r([nil,nil,[]]){next nil}
#r([1,nil,[]]){next 1}
#r([nil,nil,[]]){next []}
#r([1,nil,[]]){next [1]}
#r([nil,nil,[]]){next [nil]}
#r([[],nil,[]]){next [[]]}
#r([1,2,[]]){next [1,2]}
#r([nil,nil,[]]){next [*[]]}
#r([1,nil,[]]){next [*[1]]}
#r([1,2,[]]){next [*[1,2]]}
#
#def r(val); a,b,*c = *yield(); test_ok([a,b,c] == val, 2); end
#r([[],nil,[]]){next *[[]]}
#r([1,2,[]]){next *[1,2]}
#r([1,2,[]]){next *[*[1,2]]}
