class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  with_options  presence: true do
    validates           :nickname
    validates           :birthday
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'Full-width characters' } do
      validates         :family_name
      validates         :first_name
    end
    with_options format: { with: /\A[ァ-ヶ]+\z/, message: 'Full-width katakana characters' } do
      validates         :family_name_kana
      validates         :first_name_kana
    end
  end

  has_many :products
  has_many :purchases
end
