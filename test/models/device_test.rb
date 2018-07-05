require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  teardown do
    FileUtils.copy(file_fixture("wireless_config_backup"), file_fixture("wireless_config"))
  end

  test "generates proper command to update config file" do
    device = devices(:one)
    device.allowed = true
    `#{device.change_config_file_command(file_fixture("wireless_config").expand_path)}`
    assert file_fixture("wireless_config").read.include? device.mac

    device.allowed = false
    `#{device.change_config_file_command(file_fixture("wireless_config").expand_path)}`
    assert_not file_fixture("wireless_config").read.include? device.mac
  end
end
