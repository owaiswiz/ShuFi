require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest

  def post_device(url, name: nil, mac: nil, id: nil)
    post url,
      params: {name: name, mac: mac, id: id}
    begin
      JSON.parse @response.body
    rescue JSON::ParserError
      nil
    end 
  end

  def show_devices
    get devices_show_url 
    assert_response :success

    JSON.parse @response.body
  end

  test "should add a valid device" do
    response = post_device(devices_add_url, name: 'Test Device #1', mac: 'B8:56:23:22:1F:23')
    assert_response :success
    assert response['id']
  end

  test "should not add an invalid device" do
    response = post_device(devices_add_url, mac: 'B8:56:23:22:1F:23')
    assert_response :error

    response = post_device(devices_add_url)
    assert_response :error
  end

  test "should show added devices" do
    no_of_devices = show_devices['devices'].length
    assert_difference('no_of_devices', 1) do
      post_device(devices_add_url, name: 'Test Device #1', mac: 'B8:56:23:22:1F:23')
      assert_response :success

      no_of_devices = show_devices['devices'].length
    end
  end

  test "should allow/deny device" do
    device = devices(:one)

    post_device(devices_allow_url, id: device.id)
    assert_response :success
    device.reload
    assert_equal true, device.allowed

    post_device(devices_deny_url, id: device.id)
    assert_response :success
    device.reload
    assert_equal false, device.allowed
  end

  test "should not allow/deny an invalid device" do
    post_device(devices_allow_url)
    assert_response :error

    post_device(devices_deny_url)
    assert_response :error

    post_device(devices_allow_url, id: -1)
    assert_response :error

    post_device(devices_deny_url, id: -1)
    assert_response :error
  end

  test "should edit name/mac of valid device" do
    device = devices(:one)
    new_mac = '12:34:56:78:91:12'
    new_name = 'Test phone 23480981351'

    post_device(devices_edit_url, id: device.id, mac: new_mac, name: new_name)
    assert_response :success

    device.reload
    assert_equal new_name, device.name
    assert_equal new_mac, device.mac

    new_name = 'only name should be updated'

    post_device(devices_edit_url, id: device.id, name: new_name)
    assert_response :success

    device.reload
    assert_equal new_name, device.name
    assert_equal new_mac, device.mac
  end

  test "should not edit name/mac of invalid device" do
    post_device(devices_edit_url, mac: '12:34:56', name: 'Test name')
    assert_response :error
  end
end
