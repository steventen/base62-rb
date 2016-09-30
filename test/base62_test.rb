require "base62-rb"
require "test/unit"

class Base62Test < Test::Unit::TestCase
  def test_encode
    {
      0 => "0",
      3781504209452600 => "hjNv8tS3K",
      18446744073709551615 => "lYGhA16ahyf"
    }.each do |int, base62|
      assert_equal base62, Base62.encode(int)
    end
  end

  def test_decode
    {
      "0" => 0,
      "hjNv8tS3K" => 3781504209452600,
      "lYGhA16ahyf" => 18446744073709551615
    }.each do |base62, int|
      assert_equal int, Base62.decode(base62)
    end
  end

  def test_negative_numbers
    assert_nil Base62.encode(-123)
  end
end
