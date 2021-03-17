class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product,        only: [:show, :edit, :update, :destroy]
  before_action :move_to_index,      only: [:edit, :update, :destroy]

  def index
    @products = Product.order("created_at DESC")
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

  def show
  end

  def edit
  end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:image, :product_name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_date_id, :price).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @product.user_id && @product.purchase.blank?
      redirect_to action: :index
    end
  end
end
