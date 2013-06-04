timer =
  start_timer: (time_left_DOM, time) ->
    seconds_left = String(time).substr((time.length - 2), 2)
    minutes_left = String(time).substr((time.length - 5), 2)
    hours_left = String(time).substr((time.length - 8), 2)

    countdown = setInterval (->
      timeleft = hours_left + ':' + minutes_left + ':' + seconds_left
      if hours_left <= 0 && minutes_left <= 0 && seconds_left <= 0
        stopInterval(countdown)
      if minutes_left <= 0 && seconds_left <= 0
        hours_left = hours_left - 1
      if seconds_left <= 0
        minutes_left = minutes_left - 1
        seconds_left = 60
      time_left_DOM.empty()
      time_left_DOM.append(String(time).substr(0, (time.length - 8)) + timeleft)
      seconds_left = seconds_left - 1
    ), 1000
  stop_timer: ->
    clearInterval(countdown)

expired =
  disable: (time_left_DOM, item_sold_DOM, item_bid_DOM, item_DOM) ->
    item_bid_DOM.remove()
    item_DOM.fadeTo('slow', 0.33)
    item_sold_DOM.empty()
    item_sold_DOM.append('SOLD!')
    item_sold_DOM.css
    'margin-top': '80px'
    'text-align': 'center'
    'color': 'red'
    'font-size': '56px'
    item_sold_DOM.fadeIn('slow', 0.33)

$ ->
  event_source_not_closed_items = new EventSource('/events/time_left')
  url = window.location.href

  event_source_not_closed_items.addEventListener ('time_left'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id
    time = $.parseJSON(event.data).time

    if url.search(category) > 0 && url.search('items/' + item) < 0
      time_left_DOM = $('#time_left_' + item)
      item_sold_DOM = $('#item_sold_' + item)
      item_bid_DOM = $('#item_bid_' + item)
      item_DOM = $('#item' + item)

      if time == 'This Item Has Expired'
        timer.stop_timer
        expired.disable(time_left_DOM, item_sold_DOM, item_bid_DOM, item_DOM)

      timer.start_timer(time_left_DOM, time)

    else if url.search('items/' + item) > 0
      time_left_DOM = $('#time')
      item_sold_DOM = $('#item_sold')
      item_bid_DOM = $('#item_bid')
      item_DOM = $('#item')

      if time == 'This Item Has Expired'
        timer.stop_timer
        expired.disable(time_left_DOM, item_sold_DOM, item_bid_DOM, item_DOM)

      timer.start_timer(time_left_DOM, time)