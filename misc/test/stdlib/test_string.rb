class TestString < Test::Unit::TestCase
  def test_size
    assert_output "0\n", "puts(''.size)"
    assert_output "3\n", "puts('abc'.size)"
    assert_output "3\n", "puts('abc'.length)"
  end
end
