class HomeController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.all.includes(:bids)
  end
end
