class Api::V1::Items::SearchController < ApplicationController
   def show
    render json: Item.order(:id).find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private
    def search_params
      if params["unit_price"]
        params["unit_price"] = params["unit_price"].remove('.')
      end
      params.permit(:name, :description, :merchant_id, :id, :unit_price, :created_at, :updated_at)
    end
end
