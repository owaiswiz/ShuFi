class Device < ApplicationRecord
  validates :name, :mac, presence: true
end
