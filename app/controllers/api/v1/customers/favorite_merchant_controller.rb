class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: Customer.find(params[:customer_id]).fav_merchant  
  end
end
