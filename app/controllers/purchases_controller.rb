class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :move_to_index
  
  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_product
      @purchase_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture, :city, :address, :building, :phone_number).merge(user_id: current_user.id, product_id: @product.id, token: params[:token])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def pay_product
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    if @product.purchase.present? || current_user.id == @product.user_id
      redirect_to root_path
    end
  end
end
