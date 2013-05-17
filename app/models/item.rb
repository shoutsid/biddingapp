class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates_presence_of :name, :description, :starting_price, :closing_time
  has_many :bids

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
