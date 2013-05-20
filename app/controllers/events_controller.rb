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
          @items.each_with_index do |item, i|
            sse.write({ item: item.id, highest_bid: item.highest_bid_amount, category: item.category.url }, event: "highest_bid_amount")
            sse.write({ item: item.id, time: item.time_left, category: item.category.url }, event: "time_left")
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
end
