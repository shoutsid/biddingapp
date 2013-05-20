$ ->
  url = window.location.href
  event_source = new EventSource('/events/not_closed_items')
  
  event_source.addEventListener 'time_left', (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).item

    if url.search(category) > 0 && url.search('items/' + item) > 0
      time = $.parseJSON(event.data).time
      $('#time').empty()
      $('#time').append(time)
      if $('#time').is ":contains('This Item Has Expired')"
        $('#item_bid').remove()

  event_source.addEventListener ('highest_bid_amount'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).item
    highest_bid = $.parseJSON(event.data).highest_bid

    if url.search(category) > 0  && url.search('items/' + item) > 0 && highest_bid > $('#current_bid_amount').val()
      $('#current_bid_amount').empty()
      $('#current_bid_amount').append(highest_bid)

      if highest_bid > $('#place_bid_amount').val()
        $('#place_bid_amount').attr( 'placeholder', (parseFloat(highest_bid) + 1))
        $('#place_bid_amount').attr( 'min', (parseFloat(highest_bid) + 1))
        $('#place_bid_amount').val(parseFloat(highest_bid) + 1)
