require 'sse'

class EventsController < ApplicationController
  include ActionController::Live

  def not_closed_items
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE::Client.new(response.stream)

    Item.uncached do
      begin
        loop do
          @items = Item.where(closed: false).to_a
          @items.each do |item|
            sse.write({ id: item.id, highest_bid: item.highest_bid_amount, category: item.category.url }, event: "highest_bid_amount")
            sse.write({ id: item.id, time: item.time_left, category: item.category.url }, event: "time_left")
          end
          sleep 1
        end
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure 
    sse.close
  end

  def all_bids
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE::Client.new(response.stream)

    Bid.uncached do
      begin
        loop do
          @bids = Bid.all.to_a
          @bids.each do |bid|
            sse.write({ id: bid.id, amount: bid.amount, item: bid.item.id }, event: "bid")
          end
          sleep 20
        end
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure 
    sse.close
  end
end
