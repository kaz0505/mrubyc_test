def r; return; end; a = r(); test_ok(a == nil)
def r; return nil; end; a = r(); test_ok(a == nil)
def r; return 1; end; a = r(); test_ok(a == 1)
def r; return []; end; a = r(); test_ok(a == [])
def r; return [1]; end; a = r(); test_ok(a == [1])
def r; return [nil]; end; a = r(); test_ok(a == [nil])
def r; return [[]]; end; a = r(); test_ok(a == [[]])
def r; return [*[]]; end; a = r(); test_ok(a == [])
def r; return [*[1]]; end; a = r(); test_ok(a == [1])
def r; return [*[1,2]]; end; a = r(); test_ok(a == [1,2])

def r; return *[]; end; a = r(); test_ok(a == [])
def r; return *[1]; end; a = r(); test_ok(a == [1])
def r; return *[nil]; end; a = r(); test_ok(a == [nil])
def r; return *[[]]; end; a = r(); test_ok(a == [[]])
def r; return *[*[]]; end; a = r(); test_ok(a == [])
def r; return *[*[1]]; end; a = r(); test_ok(a == [1])
def r; return *[*[1,2]]; end; a = r(); test_ok(a == [1,2])

def r; return *[[]]; end; a = *r(); test_ok(a == [[]])
def r; return *[*[1,2]]; end; a = *r(); test_ok(a == [1,2])
