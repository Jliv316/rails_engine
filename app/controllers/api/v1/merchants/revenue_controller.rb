class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params["date"]
      render json: Merchant.find(params[:merchant_id]).single_merchant_revenue_by_date(params["date"].to_date), serializer: MerchantRevenueSerializer
    else
      render json: Merchant.find(params[:merchant_id]).single_merchant_revenue, serializer: MerchantRevenueSerializer
    end
  end

  def index
    render json: Merchant.merchants_revenue_by_date(params["date"].to_date), serializer: TotalRevenueSerializer
  end
end
