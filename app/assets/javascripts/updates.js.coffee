$ ->
  event_source_updates = new EventSource('/events/updates')
  url = window.location.href

  recent_activity_DOM = $('#recent_activity')
  current_user_DOM = $('#user_id')
  balance_DOM = $('#user_balance')
  balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
  item_bid_DOM = $('#item_bid')

  # On form submittion, check if user has enough balance 
  $('[id^=new_bid_]').each (index) ->
    form = this
    $(form).submit ->
      if parseFloat($('#input_bid_amount', form).val()) > parseFloat(balance_placeholder_DOM)
        balance_DOM.animate( { backgroundColor: '#CC3333' } )
        $('#unable_to_bid').modal('show')

  event_source_updates.addEventListener ('updates.new_bid'), (event) ->

    bid = $.parseJSON(event.data)
    balance = bid.user.balance
    highest_bid = bid.amount
    item = bid.item
    item_id = item.id
    category = item.category.url
    current_bid_user = bid.user.username
    current_bid_user_id = bid.user.id
    placeholder_string = 'Bid: ' + bid.amount + ', by ' + bid.user.username + ', on ' + bid.item.name

    all =
      bid_actions: (current_user_DOM, balance_DOM, balance_placeholder_DOM, item_bid_DOM,input_bid_DOM, current_bid_DOM, current_bid_user_DOM, time_DOM, starting_price_DOM) ->
        if current_bid_user_DOM.html() != 'bid by: ' + current_bid_user
          current_bid_user_DOM.effect( "explode", { times: 1 }, "slow", ->
            setTimeout (->
              current_bid_user_DOM.removeAttr("style").hide().fadeIn()
            ), 500
          )
        current_bid_user_DOM.empty()
        current_bid_user_DOM.append(current_bid_user)

        if parseFloat(current_user_DOM.val()) != parseFloat(current_bid_user_id)
          input_bid_DOM.removeAttr('disabled')
        else
          input_bid_DOM.attr('disabled', 'disabled')
       
        if parseFloat(highest_bid) >= parseFloat(current_bid_DOM.html())
          current_bid_DOM.empty()
          current_bid_DOM.append(highest_bid)

        if parseFloat(current_bid_DOM.html()) >= parseFloat(input_bid_DOM.val())
          input_bid_DOM.attr( 'placeholder', (parseFloat(highest_bid) + 1))
          input_bid_DOM.attr( 'min', (parseFloat(highest_bid) + 1))
          input_bid_DOM.val(parseFloat(highest_bid) + 1)

    new_top_bid = current_bid_user + ' bidded ' + highest_bid + ', just now. <hr/>'
    $('#topbids').prepend(new_top_bid)
    new_top_bid = ''
   
    input_bid_DOM = $('#item_bid_' + item_id + ' #input_bid_amount')
    current_bid_DOM = $('#current_bid_amount_' + item_id)
    current_bid_user_DOM = $('#current_bid_user_' + item_id)
    starting_price_DOM = parseFloat($('#starting_price').html())

    all.bid_actions(current_user_DOM, balance_DOM, balance_placeholder_DOM, item_bid_DOM, input_bid_DOM, current_bid_DOM, current_bid_user_DOM, starting_price_DOM)

    if recent_activity_DOM.attr('placeholder') != placeholder_string
      recent_activity_DOM.effect( "explode", { times: 1 }, "slow", ->
        setTimeout (->
          recent_activity_DOM.removeAttr("style").hide().fadeIn()
        ), 500
      )
      recent_activity_DOM.attr( 'placeholder', placeholder_string)


  event_source_updates.addEventListener ('updates.balance'), (event) ->
    user = $.parseJSON(event.data)
    user_id = user.id
    balance = user.balance

    # check for the user and that balance is not currently displayed
    if user_id == parseFloat(current_user_DOM.val())
      balance_DOM.attr( 'placeholder', balance )

      i = 0
      while i < 2
        balance_DOM.animate( { backgroundColor:	'rgba(102, 153, 153, 0.2)' } ).fadeTo("slow", 0.5, ->
          $(this).removeAttr('style')
        ).fadeTo("slow", 1.0)
        i++
