class CompleteAuction
  ## TODO:- Add some payment method etc
  @queue = :check_complete_auction_queue

  def self.perform(item_id)
    begin
      loop do
        item = Item.find(item_id)
        if item.expired?
          puts "name: #{item.name}, item_id: #{item.id}, bid_id: #{item.highest_bid.id if item.highest_bid}, bid_amount: #{item.highest_bid.amount if item.highest_bid}"
          item.close_auction
          break
        else
          Resque.enqueue(CompleteAuction, item_id)
          sleep(2.seconds)
          break
        end
      end
    end
  end
end
