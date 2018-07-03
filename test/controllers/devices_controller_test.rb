require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get devices_add_url
    assert_response :success
  end

  test "should get allow" do
    get devices_allow_url
    assert_response :success
  end

  test "should get deny" do
    get devices_deny_url
    assert_response :success
  end

  test "should get edit" do
    get devices_edit_url
    assert_response :success
  end

end
