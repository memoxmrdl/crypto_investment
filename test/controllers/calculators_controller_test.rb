require "test_helper"

class CalculatorsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = {
      investment_calculator: {
        amount: 500.0
      }
    }
    @expected_content = "$897.93"
  end

  def test_it_responds_success_and_generates_investment_table
    post calculators_path, params: @params, as: :turbo_stream

    assert_response :success
    assert_select "td", @expected_content
  end

  def test_it_responds_success_but_it_shows_error
    @params[:investment_calculator][:amount] = 0

    post calculators_path, params: @params, as: :turbo_stream

    assert_response :success
    assert_select ".help-error", "debe ser mayor que 0"
  end

  def test_it_exports_to_csv
    @params[:investment_calculator][:coin] = :bitcoin

    post calculators_path(format: :csv), params: @params

    assert_response :success
  end

  def test_it_exports_to_json
    @params[:investment_calculator][:coin] = :bitcoin

    post calculators_path(format: :json), params: @params

    assert_response :success
  end
end
