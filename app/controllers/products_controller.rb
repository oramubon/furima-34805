class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :product_name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_date_id, :price).merge(user_id: current_user.id)
  end
end
