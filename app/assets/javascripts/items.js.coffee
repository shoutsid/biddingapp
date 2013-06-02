### Event Listeners
## highest_bid_user 
# id:       typeOf(String)
#           kindOf(Item)
#           { id => '1' }
#
# user:     typeOf(String)
#           user => '20'
#           kindOf(User.id)
#
# username: typeOf(String) 
#           kindOf(User.username)
#           { username => 'Micheal109' }
#
# category: typeOf(String)
#           kindOf(Category.url)
#           { category => 'technology' }
#
# highest_bid:  typeOf(Float)
#               kindOf(Item.highest_bid_amount)
#               { highest_bid => 200.0 }
#
# starting_price: typeOf(Float)
#                 kindOf(Item.starting_price)
#                 { starting_price => 50.0 }
## time_left
# id:       typeOf(String)
#           kindOf(Item)
#           { id => '1' }
#
# time:     typeOf(Float)
#           kindOf(Item.time)
#           { time => 400000.0 }
#
# category: typeOf(String)
#           kindOf(Category.url)
#           { category => 'technology' }
#
##############################################
$ ->
  $('#user_stats').popover
   html: true
   placement: 'right'
   trigger: 'hover'

  url = window.location.href
  event_source = new EventSource('/events/not_closed_items')
  new_top_bid = ''

  current_user_DOM = $('#user_id')
  balance_DOM = $('#user_balance')
  balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
  item_bid_DOM = $('#item_bid')
  input_bid_DOM = $('#input_bid_amount')
  current_bid_DOM = $('#current_bid_amount')
  current_bid_user_DOM = $('#current_bid_user')
  time_DOM = $('#time')

  # On form submittion, check if user has enough balance 
  $('#new_bid').submit ->
    if input_bid_DOM.val() > parseFloat($('#user_balance').attr( 'placeholder' ))
      $('#unable_to_bid').modal('show')
      balance_DOM.animate( { backgroundColor: '#CC3333' } )

  event_source.addEventListener ('highest_bid'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id
    highest_bid = $.parseJSON(event.data).highest_bid
    current_bid_user = $.parseJSON(event.data).username
    current_bid_user_id = $.parseJSON(event.data).user

    if url.search(category) > 0 && url.search('items/' + item) > 0
    # When current bid user is different than present, do some affects and append new
      if current_bid_user_DOM.html() != 'bid by: ' + current_bid_user
        current_bid_user_DOM.effect( "explode", { times: 1 }, "slow", ->
            setTimeout (->
              current_bid_user_DOM.removeAttr("style").hide().fadeIn()
            ), 500
        )
        current_bid_user_DOM.empty()
        current_bid_user_DOM.append('bid by: ' + current_bid_user)

        # Update Top Bids with new bid details
        new_top_bid = current_bid_user + ' bidded ' + highest_bid + ', just now. <hr/>'
        $('#topbids').prepend(new_top_bid)
        new_top_bid = ''

      # if not current bidder, remove any disabled attributes
      if current_user_DOM.val() != current_bid_user_id
        input_bid_DOM.removeAttr('disabled')
      else
        # if current bidder disable the form
        input_bid_DOM.attr('disabled', 'disabled')

    if url.search(category) > 0  && url.search('items/' + item) > 0 && highest_bid >= current_bid_DOM.val()
      current_bid_DOM.empty()
      current_bid_DOM.append(highest_bid)
      
      # Replace bid form input and placeholders to correct values
      if highest_bid > parseFloat(input_bid_DOM.val())
        input_bid_DOM.attr( 'placeholder', (parseFloat(highest_bid) + 1))
        input_bid_DOM.attr( 'min', (parseFloat(highest_bid) + 1))
        input_bid_DOM.val(parseFloat(highest_bid) + 1)

      # Replace bid form input and placeholders to correct values
      starting_price_DOM = parseFloat($('#starting_price').html())
      if starting_price_DOM >= parseFloat(input_bid_DOM.val())
        input_bid_DOM.attr( 'placeholder', (starting_price_DOM + 1))
        input_bid_DOM.attr( 'min', (starting_price_DOM + 1))
        input_bid_DOM.val(starting_price_DOM + 1)

  event_source.addEventListener 'time_left', (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id

    if url.search(category) > 0 && url.search('items/' + item) > 0
      time = $.parseJSON(event.data).time

      time_DOM.empty()
      time_DOM.append(time)

      # When expired strip form, then mark as expired
      if time_DOM.is ":contains('This Item Has Expired')"
        item_bid_DOM.remove()
