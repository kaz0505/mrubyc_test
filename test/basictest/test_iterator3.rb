test_check "iterator3"

def call_argument_test(state, proc, *args)
  x = state
  begin
    proc.call(*args)
  rescue ArgumentError
    x = !x
  end
  test_ok(x,2)
end

call_argument_test(true, lambda{||})
#mrubyで通らない
#call_argument_test(false, lambda{||}, 1)
call_argument_test(true, lambda{|a,|}, 1)
call_argument_test(false, lambda{|a,|})
#call_argument_test(false, lambda{|a,|}, 1,2)

call_argument_test(true, Proc.new{||})
call_argument_test(true, Proc.new{||}, 1)
call_argument_test(true, Proc.new{|a,|}, 1)
call_argument_test(true, Proc.new{|a,|})
call_argument_test(true, Proc.new{|a,|}, 1,2)

def block_get(&block)
  block
end

test_ok(Proc == block_get{}.class)
call_argument_test(true, block_get{||})
call_argument_test(true, block_get{||}, 1)
call_argument_test(true, block_get{|a,|}, 1)
call_argument_test(true, block_get{|a,|})
call_argument_test(true, block_get{|a,|}, 1,2)

call_argument_test(true, block_get(&lambda{||}))
#mrubyで通らない
#call_argument_test(false, block_get(&lambda{||}),1)
call_argument_test(true, block_get(&lambda{|a,|}),1)
#call_argument_test(false, block_get(&lambda{|a,|}),1,2)

blk = block_get{11}
test_ok(blk.class == Proc)
test_ok(blk.to_proc.class == Proc)
test_ok(blk.clone.call == 11)
test_ok(block_get(&blk).class == Proc)

lmd = lambda{44}
test_ok(lmd.class == Proc)
test_ok(lmd.to_proc.class == Proc)
test_ok(lmd.clone.call == 44)
test_ok(block_get(&lmd).class == Proc)

test_ok(Proc.new{|a,| a}.yield(1,2,3) == 1)
call_argument_test(true, Proc.new{|a,|}, 1,2)

test_ok(Proc.new{|&b| b.call(10)}.call {|x| x} == 10)
test_ok(Proc.new{|a,&b| b.call(a)}.call(12) {|x| x} == 12)

