*a = nil; test_ok(a == [nil])
*a = 1; test_ok(a == [1])
*a = []; test_ok(a == [])
*a = [1]; test_ok(a == [1])
*a = [nil]; test_ok(a == [nil])
*a = [[]]; test_ok(a == [[]])
*a = [1,2]; test_ok(a == [1,2])
*a = [*[]]; test_ok(a == [])
*a = [*[1]]; test_ok(a == [1])
*a = [*[1,2]]; test_ok(a == [1,2])

*a = *[]; test_ok(a == [])
*a = *[1]; test_ok(a == [1])
*a = *[nil]; test_ok(a == [nil])
*a = *[[]]; test_ok(a == [[]])
*a = *[1,2]; test_ok(a == [1,2])
*a = *[*[]]; test_ok(a == [])
*a = *[*[1]]; test_ok(a == [1])
*a = *[*[1,2]]; test_ok(a == [1,2])

a,b,*c = nil; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = 1; test_ok([a,b,c] == [1,nil,[]])
a,b,*c = []; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = [1]; test_ok([a,b,c] == [1,nil,[]])
a,b,*c = [nil]; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = [[]]; test_ok([a,b,c] == [[],nil,[]])
a,b,*c = [1,2]; test_ok([a,b,c] == [1,2,[]])
a,b,*c = [*[]]; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = [*[1]]; test_ok([a,b,c] == [1,nil,[]])
a,b,*c = [*[1,2]]; test_ok([a,b,c] == [1,2,[]])

a,b,*c = *[]; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = *[1]; test_ok([a,b,c] == [1,nil,[]])
a,b,*c = *[nil]; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = *[[]]; test_ok([a,b,c] == [[],nil,[]])
a,b,*c = *[1,2]; test_ok([a,b,c] == [1,2,[]])
a,b,*c = *[*[]]; test_ok([a,b,c] == [nil,nil,[]])
a,b,*c = *[*[1]]; test_ok([a,b,c] == [1,nil,[]])
a,b,*c = *[*[1,2]]; test_ok([a,b,c] == [1,2,[]])

#def f; yield nil; end; f {|a| test_ok(a == nil)}
#def f; yield 1; end; f {|a| test_ok(a == 1)}
#def f; yield []; end; f {|a| test_ok(a == [])}
#def f; yield [1]; end; f {|a| test_ok(a == [1])}
#def f; yield [nil]; end; f {|a| test_ok(a == [nil])}
#def f; yield [[]]; end; f {|a| test_ok(a == [[]])}
#def f; yield [*[]]; end; f {|a| test_ok(a == [])}
#def f; yield [*[1]]; end; f {|a| test_ok(a == [1])}
#def f; yield [*[1,2]]; end; f {|a| test_ok(a == [1,2])}
#def f; yield *[]; end; f {|a| test_ok(a == nil)}
#def f; yield *[1]; end; f {|a| test_ok(a == 1)}
#def f; yield *[nil]; end; f {|a| test_ok(a == nil)}
#def f; yield *[[]]; end; f {|a| test_ok(a == [])}
#def f; yield *[*[]]; end; f {|a| test_ok(a == nil)}
#def f; yield *[*[1]]; end; f {|a| test_ok(a == 1)}
#def f; yield *[*[1,2]]; end; f {|a| test_ok(a == 1)}
#
#def f; yield; end; f {|a,| test_ok(a == nil)}
#def f; yield nil; end; f {|a,| test_ok(a == nil)}
#def f; yield 1; end; f {|a,| test_ok(a == 1)}
#def f; yield []; end; f {|a,| test_ok(a == nil)}
#def f; yield [1]; end; f {|a,| test_ok(a == 1)}
#def f; yield [nil]; end; f {|a,| test_ok(a == nil)}
#def f; yield [[]]; end; f {|a,| test_ok(a == [])}
#def f; yield [*[]]; end; f {|a,| test_ok(a == nil)}
#def f; yield [*[1]]; end; f {|a,| test_ok(a == 1)}
#def f; yield [*[1,2]]; end; f {|a,| test_ok(a == 1)}
#
#def f; yield *[]; end; f {|a,| test_ok(a == nil)}
#def f; yield *[1]; end; f {|a,| test_ok(a == 1)}
#def f; yield *[nil]; end; f {|a,| test_ok(a == nil)}
#def f; yield *[[]]; end; f {|a,| test_ok(a == nil)}
#def f; yield *[*[]]; end; f {|a,| test_ok(a == nil)}
#def f; yield *[*[1]]; end; f {|a,| test_ok(a == 1)}
#def f; yield *[*[1,2]]; end; f {|a,| test_ok(a == 1)}
#
#def f; yield; end; f {|*a| test_ok(a == [])}
#def f; yield nil; end; f {|*a| test_ok(a == [nil])}
#def f; yield 1; end; f {|*a| test_ok(a == [1])}
#def f; yield []; end; f {|*a| test_ok(a == [[]])}
#def f; yield [1]; end; f {|*a| test_ok(a == [[1]])}
#def f; yield [nil]; end; f {|*a| test_ok(a == [[nil]])}
#def f; yield [[]]; end; f {|*a| test_ok(a == [[[]]])}
#def f; yield [1,2]; end; f {|*a| test_ok(a == [[1,2]])}
#def f; yield [*[]]; end; f {|*a| test_ok(a == [[]])}
#def f; yield [*[1]]; end; f {|*a| test_ok(a == [[1]])}
#def f; yield [*[1,2]]; end; f {|*a| test_ok(a == [[1,2]])}
#
#def f; yield *[]; end; f {|*a| test_ok(a == [])}
#def f; yield *[1]; end; f {|*a| test_ok(a == [1])}
#def f; yield *[nil]; end; f {|*a| test_ok(a == [nil])}
#def f; yield *[[]]; end; f {|*a| test_ok(a == [[]])}
#def f; yield *[*[]]; end; f {|*a| test_ok(a == [])}
#def f; yield *[*[1]]; end; f {|*a| test_ok(a == [1])}
#def f; yield *[*[1,2]]; end; f {|*a| test_ok(a == [1,2])}
#
#def f; yield; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield nil; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield 1; end; f {|a,b,*c| test_ok([a,b,c] == [1,nil,[]])}
#def f; yield []; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield [1]; end; f {|a,b,*c| test_ok([a,b,c] == [1,nil,[]])}
#def f; yield [nil]; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield [[]]; end; f {|a,b,*c| test_ok([a,b,c] == [[],nil,[]])}
#def f; yield [*[]]; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield [*[1]]; end; f {|a,b,*c| test_ok([a,b,c] == [1,nil,[]])}
#def f; yield [*[1,2]]; end; f {|a,b,*c| test_ok([a,b,c] == [1,2,[]])}
#
#def f; yield *[]; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield *[1]; end; f {|a,b,*c| test_ok([a,b,c] == [1,nil,[]])}
#def f; yield *[nil]; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield *[[]]; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield *[*[]]; end; f {|a,b,*c| test_ok([a,b,c] == [nil,nil,[]])}
#def f; yield *[*[1]]; end; f {|a,b,*c| test_ok([a,b,c] == [1,nil,[]])}
#def f; yield *[*[1,2]]; end; f {|a,b,*c| test_ok([a,b,c] == [1,2,[]])}
