require "test_helper"

class SignUpUserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sign_up_user_index_url
    assert_response :success
  end
end
