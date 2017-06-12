require 'test_helper'

class YouTubeControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get you_tube_controller_index_url
    assert_response :success
  end

  test "should get show" do
    get you_tube_controller_show_url
    assert_response :success
  end

  test "should get search" do
    get you_tube_controller_search_url
    assert_response :success
  end

end
