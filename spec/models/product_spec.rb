require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it 'product_name、description、category_id、condition_id、delivery_fee_id、prefecture_id、delivery_date_id、priceが存在すれば出品できる' do
        expect(@product).to be_valid
      end
    end
    context '商品出品できないとき' do
      it 'imageが空では登録できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it 'product_nameが空では登録できない' do
        @product.product_name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Product name can't be blank")
      end
      it 'descriptionが空では登録できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーが---では登録できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Category Select")
      end
      it '商品の状態が---では登録できない' do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition Select")
      end
      it '配送料の負担が---では登録できない' do
        @product.delivery_fee_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery fee Select")
      end
      it '発送元の地域が---では登録できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture Select")
      end
      it '発送までの日数が---では登録できない' do
        @product.delivery_date_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery date Select")
      end
      it 'priceが空では登録できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("User must exist")
      end
      it 'priceが半角数字でない場合は登録できない' do
        @product.price = '１２３４'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end
      it 'priceが299以下の場合は登録できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end
      it 'priceが10000000以上の場合は登録できない' do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end
    end
  end
end
