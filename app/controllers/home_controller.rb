class HomeController < ApplicationController
  def index
    @category = Category.first
    @categories = Category.includes(items: [:bids]).where(items: { closed: false }).references(:items)
    @user_voice = Item.includes(:user, :bids, :category).where(closed: false).order(bids_count: :desc).limit(10)
  end
end
