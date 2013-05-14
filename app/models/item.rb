class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :name, :description, presence: true
  has_many :bids

  has_one :highest_bid, class_name: 'Bid', foreign_key: :item_id
end
