class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates_presence_of :name, :description, :starting_price, :closing_time
  has_many :bids

  has_one :highest_bid, class_name: 'Bid', foreign_key: :item_id

  def time_left
    if expired?
      "This Item Has Expired"
    else
      "Time left: " + check_time_left.to_s  + " Seconds"
    end
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
end
