$ ->
  event_source = new EventSource('/events/not_closed_items')
  url = window.location.href

  $('[id^=time_left]').each (index) ->

    event_source.addEventListener ('time_left'), (event) ->
      category = $.parseJSON(event.data).category
      item = $.parseJSON(event.data).item

      if url.search(category) > 0 
        time = $.parseJSON(event.data).time

        $('#time_left_' + item).empty()
        $('#time_left_' + item).append(time)

        if $('#time_left_' + item).is ":contains('This Item Has Expired')"
          $('#item_bid_' + item).remove()
          $('#item_' + item).fadeTo('slow', 0.33)
          $('#item_sold_' + item).empty()
          $('#item_sold_' + item).append('SOLD!')
          $('#item_sold_' + item).css
            'margin-top': '80px'
            'text-align': 'center'
            'color': 'red'
            'font-size': '56px'
          $('#item_sold_' + index).fadeIn('slow', 0.33)
  

  $('[id^=current_bid_amount]').each (index) ->

    event_source.addEventListener ('highest_bid_amount'), (event) ->
      category = $.parseJSON(event.data).category
      item = $.parseJSON(event.data).item
      highest_bid = $.parseJSON(event.data).highest_bid
      state = false
      
      if url.search(category) > 0 && highest_bid > $('#current_bid_amount_' + item).val() 
        $('#current_bid_amount_' + item).empty()
        $('#current_bid_amount_' + item).append(highest_bid)
        
        if highest_bid > $('#item_bid_' + item + ' #input_bid_amount').val()
          $('#item_bid_' + item + ' #input_bid_amount').attr( 'placeholder', (parseFloat(highest_bid) + 1))
          $('#item_bid_' + item + ' #input_bid_amount').attr( 'min', (parseFloat(highest_bid) + 1))
          $('#item_bid_' + item + ' #input_bid_amount').val(parseFloat(highest_bid) + 1)
