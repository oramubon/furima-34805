class Purchase < ApplicationRecord
  belongs_to :product
  has_one    :address
  
  attr_accessor :token
  validates :token, presence: true
end
