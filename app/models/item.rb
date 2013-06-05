require 'time_diff'
class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates_presence_of :name, :description, :starting_price, :closing_time, :min_accept_bid, :user
  after_create :bg_worker_complete_auction
  after_create :not_closed

  mount_uploader :image, ItemImageUploader

  def time_left
    time = check_time_left
    if expired?
      '00:00:00'
    else
      time[:diff]
    end
  end

  def highest_bid 
    bids.max 
  end

  def second_highest_bid
    last_2_bids = bids.order(amount: :desc).limit(2)
    last_2_bids[1]
  end

  def highest_bid_amount
    highest_bid == nil ? 0 : highest_bid.amount 
  end

  def min_bid_amount
    highest_bid == nil ? starting_price + 1 : highest_bid.amount + 1 
  end

  def increase_time_left
    update(closing_time: closing_time + 10.seconds)
  end

  def check_time_left 
    Time.diff(Time.now, closing_time)
  end

  def expired?
    closing_time <= Time.now
  end

  def accept_highest_bid?
    highest_bid_amount > min_accept_bid
  end

  def close_auction
    if expired? && accept_highest_bid?
      update(closed: true, sold: true)
      user.update_user_balance_by(highest_bid.amount)
      ItemMailer.item_sold_owner(self, highest_bid).deliver
      ItemMailer.item_sold_bidder(self, highest_bid).deliver

    elsif expired? == true && accept_highest_bid? == false
      update(closed: true, sold: false)          
      highest_bid.user.update_user_balance_by(highest_bid.amount) if highest_bid
      ItemMailer.item_not_sold_owner(self).deliver
    end
  end

  private 
  def bg_worker_complete_auction
    Resque.enqueue(CompleteAuction, id)
  end
   
  def not_closed
    update(closed: false)
  end
end
