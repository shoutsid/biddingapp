require 'sse'

class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_category  

  include ActionController::Live

  def index
    @items = Item.all
  end

  def show

    respond_to do |format|
      format.html
      format.js
    end

  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to category_item_path(@category, @item), notice: 'Item was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to category_item_path(@category, @item), notice: 'Item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to category_items_path, notice: 'Item was successfully destroyed.'
  end

  def time_left 
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE::Client.new(response.stream)

    @item = Item.find(params[:item_id])
    begin
      loop do
        sse.write({ time: @item.time_left }, event: 'time_left')
        sleep 1
      end
    rescue IOError
      logger.info "Stream closed"
    ensure 
      sse.close
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @category = Category.find_by_url(params[:category_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :starting_price, :min_accept_bid, :closing_time)
  end
end
