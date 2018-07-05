require 'net/ssh'

class Device < ApplicationRecord
  validates :name, :mac, presence: true
  before_update :update_status_on_router, if: :will_save_change_to_allowed?

  def update_status_on_router
    return if Rails.env == 'test'
    Net::SSH.start('192.168.1.1', 'root') do | ssh | 
      ssh.exec! change_config_file_command("/etc/config/wireless")
      ssh.exec! 'wifi'
    end
  end

  def change_config_file_command file_path
    if self.allowed
      "sed -i '/option macfilter/a list maclist #{self.mac}' #{file_path}"
    else
      "sed -i '/#{self.mac}/d' #{file_path}"
    end
  end
end
