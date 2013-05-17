class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates_presence_of :item, :amount
  validates_numericality_of :amount, on: :create,
                                    greater_than: Proc.new { |bid| bid.highest_bid }
  after_create :update_highest_bidder
  after_create :bump_item_time_left
  validate :item_expired, if: :item
  
  def item_expired
    errors.add(:item, "Can't bid on an expired item.") if item.expired?
  end

  def highest_bid
    highest_bid = item.highest_bid
    highest_bid ? highest_bid.amount.to_f : item.starting_price
  end

  private
  def update_highest_bidder
    Proc.new { |bid| bid.item.highest_bid = bid
      bid.item.save
    }
  end

  def bump_item_time_left
    item.increase_time_left
  end

end
