class Product < ApplicationRecord
  belongs_to       :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :price
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_date

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_date_id
  end

end
