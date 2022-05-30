class PromotionsController < ApplicationController

  def index
    render json: Promotion.all
  end
end