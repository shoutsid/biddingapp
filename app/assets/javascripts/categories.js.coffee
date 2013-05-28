$ ->
  event_source_not_closed_items = new EventSource('/events/not_closed_items')
  url = window.location.href

  event_source_not_closed_items.addEventListener ('highest_bid_user'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id

    current_bid_user_DOM = $('#current_bid_user_' + item)
    current_user_DOM = $('#user_id')
    input_bid_DOM = $('#item_bid_' + item + ' #input_bid_amount')
    balance_DOM = $('#user_balance')
    balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
    new_bid_form = $('#new_bid_' + item)

    $('[id^=new_bid_]').each (index) ->
      form = this
      $(form).submit ->
        if $('#input_bid_amount', form).val() > parseFloat(balance_placeholder_DOM)
          balance_DOM.animate( { backgroundColor: '#CC3333' } )
          $('#unable_to_bid').modal('show')
   
    if url.search(category) > 0
      current_bid_user = $.parseJSON(event.data).username
      current_bid_user_id = $.parseJSON(event.data).user

      if current_bid_user_DOM.html() != 'bid by: ' + current_bid_user
        current_bid_user_DOM.effect( "explode", { times: 1 }, "slow", ->
            setTimeout (->
              current_bid_user_DOM.removeAttr("style").hide().fadeIn()
            ), 500
        )
        current_bid_user_DOM.empty()
        current_bid_user_DOM.append('bid by: ' + current_bid_user)

      if current_user_DOM.val() != current_bid_user_id
        input_bid_DOM.removeAttr('disabled')
        i = 0
        while i < 3
          input_bid_DOM.fadeTo("100", 0.5).fadeTo("100", 1.0)
          i++
      else
        input_bid_DOM.attr('disabled', 'disabled')

  event_source_not_closed_items.addEventListener ('time_left'), (event) ->
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
  
  event_source_not_closed_items.addEventListener ('highest_bid_amount'), (event) ->
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
