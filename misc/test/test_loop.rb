class TestLoop < Test::Unit::TestCase
  def test_while
    assert_output "8\n", <<~EOD
      i, n = 0, 1
      while i < 3
        n *= 2
        i += 1
      end
      puts n
    EOD
  end

  def test_until
    assert_output "8\n", <<~EOD
      i, n = 0, 1
      until i == 3
        n *= 2
        i += 1
      end
      puts n
    EOD
  end
end
