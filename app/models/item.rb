class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates_presence_of :name, :description, :starting_price, :closing_time, :min_accept_bid
  has_many :bids
  after_create :bg_worker_complete_auction

  def time_left
    if expired?
      "This Item Has Expired"
    else
      "Time left: " + check_time_left.to_s  + " Seconds"
    end
  end

  def highest_bid 
    bids.max 
  end

  def highest_bid_amount
    highest_bid == nil ? 0 : highest_bid.amount 
  end

  def increase_time_left
    update(closing_time: closing_time + 10.seconds)
  end

  def check_time_left 
    TimeDifference.between(closing_time, Time.now).in_seconds.round(0)
  end

  def expired?
    closing_time <= Time.now
  end

  def accept_highest_bid?
    highest_bid_amount > min_accept_bid
  end

  def close_auction
    ## TODO:- Notify the winning bidder they won the auction
    #         Notify the auction owner that they sold the item
    if expired? && accept_highest_bid?
      update(closed: true)
      ## TODO:- Notify the auction owner that their asking price
      #         was not met.
    elsif expired? == true && accept_highest_bid? == false
      update(closed: true)          
    end
  end

  private 
  def bg_worker_complete_auction
    Resque.enqueue(CompleteAuction, id)
  end
end
