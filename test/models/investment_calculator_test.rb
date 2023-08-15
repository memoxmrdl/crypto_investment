require "test_helper"

class InvestmentCalculatorTest < ActiveSupport::TestCase
  def setup
    @subject = InvestmentCalculator.new
  end

  def test_it_valids
    @subject.amount = 1

    assert @subject.valid?
  end

  def test_it_invalids
    assert_not @subject.valid?
  end
end
