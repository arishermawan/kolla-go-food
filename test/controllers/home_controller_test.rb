require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get hello" do
    get home_hello_url
    assert_response :success
  end

end
