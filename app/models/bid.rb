class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates_presence_of :item, :amount
  validates_numericality_of :amount, on: :create,
                                    greater_than: Proc.new { |bid| highest_bid(bid) }
  after_create :update_highest_bidder
  

  private
  def update_highest_bidder
    Proc.new { |bid| bid.item.highest_bid = bid
      bid.item.save
    }
  end

  def self.highest_bid(bid)
    item = bid.item
    highest_bid = item.highest_bid

    highest_bid ? highest_bid.amount.to_f : item.starting_price
  end
end
