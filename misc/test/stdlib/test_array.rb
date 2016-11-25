class TestArray < Test::Unit::TestCase
  def test_bin_plus
    assert_output "true\n", "puts([1] + [2] == [1, 2])"
  end

  def test_bin_equal
    assert_output "true\n", "puts([1, [2]] == [1, [2]])"
  end

  def test_empty?
    assert_output "true\n", "puts([].empty?)"
    assert_output "false\n", "puts([nil].empty?)"
  end

  def test_size
    assert_output "3\n", "puts([1,2,3].size)"
    assert_output "3\n", "puts([1,2,3].length)"
    assert_output "3\n", "puts([1,2,3].count)"
  end
end
