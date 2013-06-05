class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, counter_cache: true
  validates_presence_of :item, :amount
  validates_numericality_of :amount, on: :create,
                                    greater_than_or_equal_to: Proc.new { |bid| bid.item.min_bid_amount.to_f }
  after_create :bump_item_time_left
  after_create :deduct_from_balance
  after_create :reimberse_previous_bidder
  after_create :push_to_redis

  validate :item_expired, if: :item
  validate :check_balance, if: :user
  
  private
  def bump_item_time_left
    item.increase_time_left
  end

  def item_expired
    errors.add(:item, "Can't bid on an expired item.") if item.expired?
  end

  def check_balance
    errors.add(:amount, "You do not have enough balance to make that bid.") unless user.has_enough_balance_to_bid?(amount)
  end

  def deduct_from_balance
    user.update_user_balance_by(-amount)
  end

  def reimberse_previous_bidder
    if item.second_highest_bid != nil
      user = item.second_highest_bid.user
      amount = item.second_highest_bid.amount
      user.update_user_balance_by(amount)
    end
  end

  def push_to_redis
    bid = self.to_json(include: [:user, item: { include: [:category] }])
    $redis.publish('updates.new_bid', bid)
  end
end
