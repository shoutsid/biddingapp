class HomeController < ApplicationController
  def index
    @category = Category.first
    @categories = Category.all
    @items = Item.all.includes(:bids)
  end
end
