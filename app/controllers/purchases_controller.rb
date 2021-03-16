class PurchasesController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.create(purchase_params)
    Address.create(address_params)
    if @purchase.valid?
      pay_product
      @purchase.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def purchase_params
    params.require(:purchase).merge(user_id: current_user.id, product_id: @product.id, token: params[:token])
  end

  def address_params
    params.permit(:post_code, :prefecture, :city, :address, :building, :phone_number).merge(purchase_id: @purchase.id)
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
