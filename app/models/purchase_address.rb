class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture, :city, :address, :building, :phone_number, :user_id, :token

  with_options presence: true do
    validates :user_id
    validates :token
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :phone_number, format: {with: /\A[0-9]{11}\z/, message: "Input only number"}
  end
  validates :prefecture, numericality: {other_than: 1, message: "Select"}

  def save
    purchase = Purchase.create(user_id: user_id)
    Address.create(post_code: post_code, prefecture: prefecture, city: city, address: address, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end