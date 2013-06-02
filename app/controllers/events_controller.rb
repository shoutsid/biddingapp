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
            sse.write({ id: "#{item.id}", time: item.time_left, category: item.category.url }, event: "time_left")
            if item.highest_bid
              sse.write({ id: "#{item.id}", user: "#{item.highest_bid.user.id}", highest_bid: item.highest_bid_amount, username: item.highest_bid.user.username, starting_price: item.starting_price, category: item.category.url }, event: "highest_bid")
            end
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

  def users_balance
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE::Client.new(response.stream)

    User.uncached do
      begin
        loop do
          @users = User.all.to_a
          @users.each do |user|
            sse.write({ id: "#{user.id}", balance: user.balance }, event: "balance")
          end
          sleep 5
        end
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure 
    sse.close
  end


  def recent_activity
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE::Client.new(response.stream)

    Bid.uncached do
      begin
        loop do
          @bid = Bid.last
            sse.write({ id: "#{@bid.id}", amount: @bid.amount, item: @bid.item.name, user: @bid.user.username }, event: "bids") if @bid
          sleep 2
         end
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure 
    sse.close
  end
end
