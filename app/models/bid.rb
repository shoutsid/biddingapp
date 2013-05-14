class Bid < ActiveRecord::Base
  validates_numericality_of :price, on: :create,
    greater_than: Proc.new { |bid| bid.item.highest_bid ? bid.item.highest_bid.price.to_f : bid.item.starting_price }
  after_create :update_item
  belongs_to :user
  belongs_to :item

  private
  def update_item
    Proc.new { |bid| bid.item.highest_bid = bid; bid.item.save
    }
  end
end
