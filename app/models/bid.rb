class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates_presence_of :item, :amount
  validates_numericality_of :amount, on: :create,
                                    greater_than_or_equal_to: Proc.new { |bid| bid.item.min_bid_amount.to_f }
  after_create :bump_item_time_left
  validate :item_expired, if: :item
  
  def item_expired
    errors.add(:item, "Can't bid on an expired item.") if item.expired?
  end

  private
  def bump_item_time_left
    item.increase_time_left
  end
end
