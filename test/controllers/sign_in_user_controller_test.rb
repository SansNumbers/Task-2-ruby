require "test_helper"

class SignInUserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sign_in_user_index_url
    assert_response :success
  end
end
