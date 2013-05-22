class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @items = Item.where(category_id: @category, closed: false).to_a
    @bid = Bid.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    
  def set_category
    @category = Category.find_by_url(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
