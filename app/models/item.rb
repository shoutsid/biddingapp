class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates_presence_of :name, :description, :starting_price, :closing_time
  has_many :bids

  has_one :highest_bid, class_name: 'Bid', foreign_key: :item_id
end
