$ ->
  event_source = new EventSource('/events/not_closed_items')
  url = window.location.href

  $('[id^=time_left]').each (index) ->

    event_source.addEventListener ('time_left'), (event) ->
      category = $.parseJSON(event.data).category
      item = $.parseJSON(event.data).id

      time_left_DOM = $('#time_left_' + item)
      item_sold_DOM = $('#item_sold_' + item)

      if url.search(category) > 0 
        time = $.parseJSON(event.data).time

        time_left_DOM.empty()
        time_left_DOM.append(time)

        if time_left_DOM.is ":contains('This Item Has Expired')"
          $('#item_bid_' + item).remove()
          $('#item_' + item).fadeTo('slow', 0.33)
          item_sold_DOM.empty()
          item_sold_DOM.append('SOLD!')
          item_sold_DOM.css
            'margin-top': '80px'
            'text-align': 'center'
            'color': 'red'
            'font-size': '56px'
          item_sold_DOM.fadeIn('slow', 0.33)
  

  $('[id^=current_bid_amount]').each (index) ->

    event_source.addEventListener ('highest_bid_amount'), (event) ->
      category = $.parseJSON(event.data).category
      item = $.parseJSON(event.data).id
      highest_bid = $.parseJSON(event.data).highest_bid

      bid_amount_DOM = $('#current_bid_amount_' + item)
      input_bid_DOM = $('#item_bid_' + item + ' #input_bid_amount')

      if url.search(category) > 0 && highest_bid > bid_amount_DOM.val()
        bid_amount_DOM.empty()
        bid_amount_DOM.append(highest_bid)
        
        if highest_bid > input_bid_DOM.val()
          input_bid_DOM.attr( 'placeholder', (parseFloat(highest_bid) + 1))
          input_bid_DOM.attr( 'min', (parseFloat(highest_bid) + 1))
          input_bid_DOM.val(parseFloat(highest_bid) + 1)
