require "test_helper"

class CoinTest < ActiveSupport::TestCase
  def setup
    @subject = Coin.new
  end

  def test_it_valids
    @subject.name = "The Graph"
    @subject.symbol = "GRT"
    @subject.slug = "the-graph"
    @subject.price = 0.1069

    assert @subject.valid?
  end

  def test_it_invalids
    assert_not @subject.valid?
  end
end
