$ ->
  url = window.location.href
  event_source = new EventSource('/events/not_closed_items')
  
  event_source.addEventListener ('highest_bid_user'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id

    input_bid_DOM = $('#input_bid_amount')
    current_bid_user_DOM = $('#current_bid_user')
    current_user_DOM = $('#user_id')
    balance_DOM = $('#user_balance')
    balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )

    if url.search(category) > 0 && url.search('items/' + item) > 0
      current_bid_user = $.parseJSON(event.data).username
      current_bid_user_id = $.parseJSON(event.data).user

      if current_bid_user_DOM.val() != current_bid_user
        current_bid_user_DOM.empty()
        current_bid_user_DOM.append('bid by: ' + current_bid_user)

      if current_user_DOM.val() != current_bid_user_id
        i = 0
        while i < 3
          input_bid_DOM.fadeTo("100", 0.5).fadeTo("100", 1.0)
          i++

      $('form').submit ->
        if input_bid_DOM.val() > balance_placeholder_DOM
          balance_DOM.animate( { backgroundColor: '#CC3333' } )

  event_source.addEventListener 'time_left', (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id

    time_DOM = $('#time')
    item_bid_DOM = $('#item_bid')

    if url.search(category) > 0 && url.search('items/' + item) > 0
      time = $.parseJSON(event.data).time

      time_DOM.empty()
      time_DOM.append(time)
      if time_DOM.is ":contains('This Item Has Expired')"
        item_bid_DOM.remove()

  event_source.addEventListener ('highest_bid_amount'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id
    highest_bid = $.parseJSON(event.data).highest_bid

    current_bid_DOM = $('#current_bid_amount')
    input_bid_DOM = $('#input_bid_amount')

    if url.search(category) > 0  && url.search('items/' + item) > 0 && highest_bid > current_bid_DOM.val()
      current_bid_DOM.empty()
      current_bid_DOM.append(highest_bid)

      if highest_bid > input_bid_DOM.val()
        input_bid_DOM.attr( 'placeholder', (parseFloat(highest_bid) + 1))
        input_bid_DOM.attr( 'min', (parseFloat(highest_bid) + 1))
        input_bid_DOM.val(parseFloat(highest_bid) + 1)
