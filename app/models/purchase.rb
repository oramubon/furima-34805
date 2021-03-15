class Purchase < ApplicationRecord
  belongs_to :product
  attr_accessor :token
  validates :token, presence: true
end
