a, = nil; test_ok(a == nil)
a, = 1; test_ok(a == 1)
a, = []; test_ok(a == nil)
a, = [1]; test_ok(a == 1)
a, = [nil]; test_ok(a == nil)
a, = [[]]; test_ok(a == [])
a, = 1,2; test_ok(a == 1)
a, = [1,2]; test_ok(a == 1)
a, = [*[]]; test_ok(a == nil)
a, = [*[1]]; test_ok(a == 1)
a, = *[1,2]; test_ok(a == 1)
a, = [*[1,2]]; test_ok(a == 1)

a, = *[]; test_ok(a == nil)
a, = *[1]; test_ok(a == 1)
a, = *[nil]; test_ok(a == nil)
a, = *[[]]; test_ok(a == [])
a, = *[1,2]; test_ok(a == 1)
a, = *[*[]]; test_ok(a == nil)
a, = *[*[1]]; test_ok(a == 1)
a, = *[*[1,2]]; test_ok(a == 1)
