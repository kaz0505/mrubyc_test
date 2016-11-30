def r; return; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return nil; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return 1; end; a,b,*c = r(); test_ok([a,b,c] == [1,nil,[]])
def r; return []; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return [1]; end; a,b,*c = r(); test_ok([a,b,c] == [1,nil,[]])
def r; return [nil]; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return [[]]; end; a,b,*c = r(); test_ok([a,b,c] == [[],nil,[]])
def r; return [1,2]; end; a,b,*c = r(); test_ok([a,b,c] == [1,2,[]])
def r; return [*[]]; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return [*[1]]; end; a,b,*c = r(); test_ok([a,b,c] == [1,nil,[]])
def r; return [*[1,2]]; end; a,b,*c = r(); test_ok([a,b,c] == [1,2,[]])

def r; return *[]; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return *[1]; end; a,b,*c = r(); test_ok([a,b,c] == [1,nil,[]])
def r; return *[nil]; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return *[[]]; end; a,b,*c = r(); test_ok([a,b,c] == [[],nil,[]])
def r; return *[1,2]; end; a,b,*c = r(); test_ok([a,b,c] == [1,2,[]])
def r; return *[*[]]; end; a,b,*c = r(); test_ok([a,b,c] == [nil,nil,[]])
def r; return *[*[1]]; end; a,b,*c = r(); test_ok([a,b,c] == [1,nil,[]])
def r; return *[*[1,2]]; end; a,b,*c = r(); test_ok([a,b,c] == [1,2,[]])

#f = lambda {|r,| test_ok([] == r)}
#f.call([], *[])
#
#f = lambda {|r,*l| test_ok([] == r); test_ok([1] == l)}
#f.call([], *[1])
#
#f = lambda{|x| x}
#test_ok(f.call(42) == 42)
#test_ok(f.call([42]) == [42])
#test_ok(f.call([[42]]) == [[42]])
#test_ok(f.call([42,55]) == [42,55])
#
#f = lambda{|x,| x}
#test_ok(f.call(42) == 42)
#test_ok(f.call([42]) == [42])
#test_ok(f.call([[42]]) == [[42]])
#test_ok(f.call([42,55]) == [42,55])
#
#f = lambda{|*x| x}
#test_ok(f.call(42) == [42])
#test_ok(f.call([42]) == [[42]])
#test_ok(f.call([[42]]) == [[[42]]])
#test_ok(f.call([42,55]) == [[42,55]])
#test_ok(f.call(42,55) == [42,55])
#
#f = lambda { |a, b=42, *c| [a,b,c] }
#test_ok(f.call(1      ) == [1,42,[  ]] )
#test_ok(f.call(1,43   ) == [1,43,[  ]] )
#test_ok(f.call(1,43,44) == [1,43,[44]] )
#
#f = lambda { |a, b=(a|16), *c, &block| [a,b,c,block&&block[]] }
#test_ok(f.call(8      )     == [8,24,[  ],nil] )
#test_ok(f.call(8,43   )     == [8,43,[  ],nil] )
#test_ok(f.call(8,43,44)     == [8,43,[44],nil] )
#test_ok(f.call(8      ){45} == [8,24,[  ],45 ] )
#test_ok(f.call(8,43   ){45} == [8,43,[  ],45 ] )
#test_ok(f.call(8,43,44){45} == [8,43,[44],45 ] )
#
#f = lambda { |a, b=42, *c, d| [a,b,c,d] }
#test_ok(f.call(1      ,99) == [1,42,[  ],99] )
#test_ok(f.call(1,43   ,99) == [1,43,[  ],99] )
#test_ok(f.call(1,43,44,99) == [1,43,[44],99] )
#
#f = lambda { |a, b=(a|16), &block| [a,b,block&&block[]] }
#test_ok(f.call(8   )     == [8,24,nil] )
#test_ok(f.call(8,43)     == [8,43,nil] )
#test_ok(f.call(8,43)     == [8,43,nil] )
#test_ok(f.call(8   ){45} == [8,24,45 ] )
#test_ok(f.call(8,43){45} == [8,43,45 ] )
#test_ok(f.call(8,43){45} == [8,43,45 ] )
#
#f = lambda { |a, b=42, d| [a,b,d] }
#test_ok(f.call(1   ,99) == [1,42,99] )
#test_ok(f.call(1,43,99) == [1,43,99] )
#test_ok(f.call(1,43,99) == [1,43,99] )
#
#f = lambda { |b=42, *c, &block| [b,c,block&&block[]] }
#test_ok(f.call(     )     == [42,[  ],nil] )
#test_ok(f.call(43   )     == [43,[  ],nil] )
#test_ok(f.call(43,44)     == [43,[44],nil] )
#test_ok(f.call(     ){45} == [42,[  ],45 ] )
#test_ok(f.call(43   ){45} == [43,[  ],45 ] )
#test_ok(f.call(43,44){45} == [43,[44],45 ] )
#
#f = lambda { |b=42, *c, d| [b,c,d] }
#test_ok(f.call(      99) == [42,[  ],99] )
#test_ok(f.call(43   ,99) == [43,[  ],99] )
#test_ok(f.call(43,44,99) == [43,[44],99] )
#
#f = lambda { |b=42, &block| [b,block&&block[]] }
#test_ok(f.call(  )     == [42,nil] )
#test_ok(f.call(43)     == [43,nil] )
#test_ok(f.call(43)     == [43,nil] )
#test_ok(f.call(  ){45} == [42,45 ] )
#test_ok(f.call(43){45} == [43,45 ] )
#test_ok(f.call(43){45} == [43,45 ] )
#
#f = lambda { |b=42, d| [b,d] }
#test_ok(f.call(   99) == [42,99] )
#test_ok(f.call(43,99) == [43,99] )
#test_ok(f.call(43,99) == [43,99] )
