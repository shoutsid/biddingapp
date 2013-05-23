class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates_presence_of :item, :amount
  validates_numericality_of :amount, on: :create,
                                    greater_than_or_equal_to: Proc.new { |bid| bid.item.min_bid_amount.to_f }
  after_create :bump_item_time_left
  validate :item_expired, if: :item
  validate :check_balance, if: :user
  
  def item_expired
    errors.add(:item, "Can't bid on an expired item.") if item.expired?
  end

  def check_balance
    errors.add(:amount, "You do not have enough balance to make that bid.") unless user.has_enough_balance_to_bid?(amount)
  end

  private
  def bump_item_time_left
    item.increase_time_left
  end
end
