class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :address, :street_number, :postal_code, :country, :username
  validates_uniqueness_of(:username)
  has_many :items
  has_many :bids

  after_update :push_to_redis

  def hard_reset_balance(amount = 0)
    update(balance: amount)
  end

  def update_user_balance_by(amount)
    update_amount = balance.to_f + amount.to_f
    update(balance: update_amount)
  end
  
  def has_enough_balance_to_bid?(amount)
    balance.to_f >= amount.to_f
  end

  def item_count
    items.count
  end

  def closed_item_count
    items.where(closed: true).count
  end
  
  def not_closed_item_count
    items.where(closed: false).count
  end

  def sold_item_count
    items.where(closed: true, sold: true).count
  end

  def not_sold_item_count
    items.where(closed: true, sold: false).count
  end

  private
  def push_to_redis
    user = self.to_json
    $redis.publish('updates.balance', user)
  end
end
