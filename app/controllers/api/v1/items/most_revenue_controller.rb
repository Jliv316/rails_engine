class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    render json: Item.revenue_by_quantity(params[:quantity])
  end
end
