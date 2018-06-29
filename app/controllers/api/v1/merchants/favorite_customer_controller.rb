class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def index
    render json: Merchant.find(params[:merchant_id]).fav_customer
  end
  
end