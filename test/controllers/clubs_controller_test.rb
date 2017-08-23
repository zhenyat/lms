require 'test_helper'

class ClubsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clubs_index_url
    assert_response :success
  end

  test "should get show" do
    get clubs_show_url
    assert_response :success
  end

end
