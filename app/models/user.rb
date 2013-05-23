class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :address, :street_number, :postal_code, :country
  has_many :items
  has_many :bids

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
end
