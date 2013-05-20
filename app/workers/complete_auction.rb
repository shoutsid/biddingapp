class CompleteAuction
  @queue = :check_complete_auction_queue

  def self.perform(item_id)
    begin 
      loop do
        item = Item.find(item_id)
        if item.expired?
          puts "name: #{item.name}, item_id: #{item.id}, bid_id: #{item.highest_bid.id if item.highest_bid}, bid_amount: #{item.highest_bid.amount if item.highest_bid}"
          item.close_auction

          ## TODO:- Add some payment method here
          #         Create some live feed data of all auctions
        end
        break if item.closed?
        sleep 20
      end
    end
  end
end
