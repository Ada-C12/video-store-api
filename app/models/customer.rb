class Customer < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
end
