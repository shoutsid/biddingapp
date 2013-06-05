class HomeController < ApplicationController
  def index
    @category = Category.first
    @categories = Category.all
    @user_voice = Item.where(closed: false).order(bids_count: :desc).limit(10)
  end
end
