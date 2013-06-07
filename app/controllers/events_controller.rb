require 'sse'

class EventsController < ApplicationController
  include ActionController::Live

  def updates
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE::Client.new(response.stream)
    redis = Redis.new

    redis.psubscribe('updates.*') do |on|
      on.pmessage do |pattern, event, data|
        sse.write_from_redis(data, event: event)
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    sse.close
  end

  def time_left
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE::Client.new(response.stream)

   begin
     Item.uncached do
       loop do
         @items = Item.where(closed: false).to_a
         @items.each do |item|
           sse.write({ id: "#{item.id}", time: item.time_left,
                     category: item.category.url
           }, event: "time_left")
         end
         sleep 60
       end
     end
   end

  rescue IOError
    logger.info "Stream closed"
  ensure
    sse.close
  end
end
