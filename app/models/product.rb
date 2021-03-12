class Product < ApplicationRecord
  belongs_to       :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    with_options format: { with: /\A[\d]+\z/, message: 'Half-width number' } do
      validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000, message: 'Out of setting range' }
    end
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_date

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_date_id
  end

end
