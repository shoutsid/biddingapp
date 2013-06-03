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
  event_source_not_closed_items = new EventSource('/events/not_closed_items')

  event_source_not_closed_items.addEventListener ('time_left'), (event) ->
    category = $.parseJSON(event.data).category
    item = $.parseJSON(event.data).id

    time_left_DOM = $('#time_left_' + item)
    item_sold_DOM = $('#item_sold_' + item)

    # Constantly update left time if category is present
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
