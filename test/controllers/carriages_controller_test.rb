require "test_helper"

class CarriagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get carriages_new_url
    assert_response :success
  end
end
