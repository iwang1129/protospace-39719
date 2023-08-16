require "test_helper"

class ProtospaceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get protospace_index_url
    assert_response :success
  end
end
