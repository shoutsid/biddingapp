require 'sse'

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  include ActionController::Live

  def index
    @categories = Category.all
  end

  def show
    @items = Item.where(category_id: @category)
    @bid = Bid.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  def time_left 
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE::Client.new(response.stream)
    
    @items = Item.where(category_id: Category.find_by_url(params[:category_id]))
    begin
      loop do
        @items.each_with_index do |item, i|
          sse.write({ time: item.time_left }, event: "time_left_#{i}")
        end
        sleep 1
      end
    rescue IOError
      logger.info "Stream closed"
    ensure 
      sse.close
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
