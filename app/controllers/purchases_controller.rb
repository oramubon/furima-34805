class PurchasesController < ApplicationController
  def index
    set_product
    @purchase_address = PurchaseAddress.new
  end

  def create
    set_product
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
    params.require(:purchase_address).permit(:post_code, :prefecture, :city, :address, :building, :phone_number).merge(user_id: current_user.id, token: params[:token])
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
end
