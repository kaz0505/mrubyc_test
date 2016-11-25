class TestConditional < Test::Unit::TestCase
  def test_if
    assert_output "ok\n", <<~EOD
      puts "ok" if 1 == 1
    EOD
    assert_output "", <<~EOD
      puts "ok" if 1 == 2
    EOD
  end

  def test_else
    assert_output "ok\n", <<~EOD
      if 1 == 2
        puts "ng"
      else
        puts "ok"
      end
    EOD
  end

  def test_unless
    assert_output "ok\n", <<~EOD
      puts "ok" unless 1 == 2
    EOD
    assert_output "", <<~EOD
      puts "ok" unless 1 == 1
    EOD
  end
end
