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
## highest_bid
# id:           typeOf(String)
#               kindOf(Item)
#               { id => '1' }
#
# highest_bid:  typeOf(Float)
#               kindOf(Item.highest_bid_amount)
#               { highest_bid => 200.0 }
#
# starting_price: typeOf(Float)
#                 kindOf(Item.starting_price)
#                 { starting_price => 50.0 }
#
# category:     typeOf(String)
#               kindOf(Category.url)
#               { category => 'technology' }
#
# user:     typeOf(String)
#           user => '20'
#           kindOf(User.id)
#
# username: typeOf(String) 
#           kindOf(User.username)
#           { username => 'Micheal109' }
###############################################
$ ->
  event_source_not_closed_items = new EventSource('/events/not_closed_items')
  url = window.location.href

  event_source_not_closed_items.addEventListener ('highest_bid'), (event) ->
 
    highest_bid = $.parseJSON(event.data).highest_bid
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id
    current_bid_user = $.parseJSON(event.data).username
    current_bid_user_id = $.parseJSON(event.data).user

    current_bid_user_DOM = $('#current_bid_user_' + item)
    current_user_DOM = $('#user_id')
    input_bid_DOM = $('#item_bid_' + item + ' #input_bid_amount')
    balance_DOM = $('#user_balance')
    balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )

    # On form submittion, check if user has enough balance 
    $('[id^=new_bid_]').each (index) ->
      form = this
      $(form).submit ->
        if $('#input_bid_amount', form).val() > parseFloat(balance_placeholder_DOM)
          balance_DOM.animate( { backgroundColor: '#CC3333' } )
          $('#unable_to_bid').modal('show')
   
    if url.search(category) > 0
      # When current bid user is different than present, do some affects and append new
      if current_bid_user_DOM.html() != current_bid_user
        current_bid_user_DOM.effect( "explode", { times: 1 }, "slow", ->
            setTimeout (->
              current_bid_user_DOM.removeAttr("style").hide().fadeIn()
            ), 500
        )
        current_bid_user_DOM.empty()
        current_bid_user_DOM.append(current_bid_user)

        #if not current bidder, remove any disabled attributes
      if current_user_DOM.val() != current_bid_user_id
        input_bid_DOM.removeAttr('disabled')
      else
        # if current bidder disable the form
        input_bid_DOM.attr('disabled', 'disabled')

    bid_amount_DOM = $('#current_bid_amount_' + item)
    input_bid_DOM = $('#item_bid_' + item + ' #input_bid_amount')

    # Check category is is present, and that highest bd amount is above displayed
    if url.search(category) > 0 && highest_bid > bid_amount_DOM.val()
      bid_amount_DOM.empty()
      bid_amount_DOM.append(highest_bid)
      
      # Replace bid form input and placeholders to correct values
      if highest_bid > parseFloat(input_bid_DOM.val())
        input_bid_DOM.attr( 'placeholder', (parseFloat(highest_bid) + 1))
        input_bid_DOM.attr( 'min', (parseFloat(highest_bid) + 1))
        input_bid_DOM.val(parseFloat(highest_bid) + 1)

      # Replace bid form input and placeholders to correct values
      starting_price_DOM = parseFloat($('#starting_price' + item ).html())
      if starting_price_DOM >= parseFloat(input_bid_DOM.val())
        input_bid_DOM.attr( 'placeholder', (starting_price_DOM + 1))
        input_bid_DOM.attr( 'min', (starting_price_DOM + 1))
        input_bid_DOM.val(starting_price_DOM + 1)

  event_source_not_closed_items.addEventListener ('time_left'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id

    time_left_DOM = $('#time_left_' + item)
    item_sold_DOM = $('#item_sold_' + item)

    # Constantly update left time if category is present
    if url.search(category) > 0
      time = $.parseJSON(event.data).time

      time_left_DOM.empty()
      time_left_DOM.append(time)

      # When expired strip form, then mark as expired
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
