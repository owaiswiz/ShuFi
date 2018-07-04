require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest

  def post_device(url, name: nil, mac: nil, id: nil)
    post url,
      params: {name: name, mac: mac, id: nil}
    JSON.parse @response.body
  end

  test "should add a valid device" do
    response = post_device(devices_add_url, name: 'Test Device #1', mac: 'B8:56:23:22:1F:23')
    assert_equal 'Device added successfully', response['status']
    assert response['id']
  end

  test "should not add an invalid device" do
    response = post_device(devices_add_url, mac: 'B8:56:23:22:1F:23')
    assert_equal 'Error occurred while adding device', response['status']

    response = post_device(devices_add_url)
    assert_equal 'Error occurred while adding device', response['status']
  end

  test "should get allow" do
    response = post_device(devices_allow_url, id: 
    assert_response :success
  end

  # test "should get deny" do
  #   get devices_deny_url
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get devices_edit_url
  #   assert_response :success
  # end

end
