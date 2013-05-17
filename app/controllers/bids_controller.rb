class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :set_item
  before_action :set_category

  def index
    @bids = Bid.all
  end

  def show
  end

  def new
    @bid = Bid.new
  end

  def edit
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.item_id = @item.id

    if @bid.save
      redirect_to category_item_path(@category, @item), notice: 'Bid was successfully created.'
    else
      render action: 'new'
    end
  end

  def update

    if @bid.update(bid_params)
      redirect_to category_item_bids_path(@category, @item), notice: 'Bid was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @bid.destroy
    redirect_to category_item_bids_url, notice: 'Bid was successfully destroyed.'
  end

  private
  def set_bid
    @bid = Bid.find(params[:id])
  end

  def set_category
    @category = Category.find_by_url(params[:category_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def bid_params
    params.require(:bid).permit(:item_id, :amount)
  end
end
