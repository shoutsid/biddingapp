class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_category  
  before_action :set_user
  before_action :authenticate_user!, except: [:index, :show]

  load_and_authorize_resource 

  def index
    redirect_to category_url(@category)
  end

  def show
    @bid = Bid.new
    @bids = Bid.where(item_id: @item).order(created_at: :desc).limit(6)
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.user = @user

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

  private
  def set_user 
    @user = current_user
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @category = Category.find_by_url(params[:category_id])
  end

  def item_params
    params.fetch(:item, {}).permit(:name, :description, :category_id, :starting_price, :min_accept_bid, :closing_time, :user, :image, :remote_image_url, :image_cache)
  end
end
