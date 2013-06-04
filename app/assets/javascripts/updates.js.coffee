$ ->
  event_source_new_bids = new EventSource('/events/updates')
  url = window.location.href
  event_source_new_bids.addEventListener ('updates.new_bid'), (event) ->

    bid = $.parseJSON(event.data)
    highest_bid = bid.amount
    item = bid.item
    item_id = item.id
    category = item.category.url
    current_bid_user = bid.user.username
    current_bid_user_id = bid.user.id
    placeholder_string = 'Bid: ' + bid.amount + ', by ' + bid.user.username + ', on ' + bid.item.name
    recent_activity_DOM = $('#recent_activity')

    all =
      bid_actions:(current_user_DOM, balance_DOM, balance_placeholder_DOM,
        item_bid_DOM,input_bid_DOM, current_bid_DOM, current_bid_user_DOM,
        time_DOM, starting_price_DOM) ->

        new_top_bid = current_bid_user + ' bidded ' + highest_bid + ', just now. <hr/>'
        $('#topbids').prepend(new_top_bid)
        new_top_bid = ''

        if current_bid_user_DOM.html() != 'bid by: ' + current_bid_user
          current_bid_user_DOM.effect( "explode", { times: 1 }, "slow", ->
            setTimeout (->
              current_bid_user_DOM.removeAttr("style").hide().fadeIn()
            ), 500
          )
        current_bid_user_DOM.empty()
        current_bid_user_DOM.append(current_bid_user)

        if parseFloat(current_user_DOM.val()) != current_bid_user_id
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


    # On form submittion, check if user has enough balance 
    $('[id^=new_bid_]').each (index) ->
      form = this
      $(form).submit ->
        if $('#input_bid_amount', form).val() > parseFloat(balance_placeholder_DOM)
          balance_DOM.animate( { backgroundColor: '#CC3333' } )
          $('#unable_to_bid').modal('show')
   
    if url.search(category) > 0 && url.search('items/' + item) < 0

      current_user_DOM = $('#user_id')
      balance_DOM = $('#user_balance')
      balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
      item_bid_DOM = $('#item_bid')
      input_bid_DOM = $('#item_bid_' + item_id + ' #input_bid_amount')
      current_bid_DOM = $('#current_bid_amount_' + item_id)
      current_bid_user_DOM = $('#current_bid_user_' + item_id)
      starting_price_DOM = parseFloat($('#starting_price').html())

      all.bid_actions(current_user_DOM, balance_DOM, balance_placeholder_DOM, item_bid_DOM,
        input_bid_DOM, current_bid_DOM, current_bid_user_DOM, starting_price_DOM)

    if url.search('items/' + item_id) > 0
      current_user_DOM = $('#user_id')
      balance_DOM = $('#user_balance')
      balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
      item_bid_DOM = $('#item_bid')
      input_bid_DOM = $('#input_bid_amount')
      current_bid_DOM = $('#current_bid_amount')
      current_bid_user_DOM = $('#current_bid_user')
      starting_price_DOM = parseFloat($('#starting_price').html())

      all.bid_actions(current_user_DOM, balance_DOM, balance_placeholder_DOM, item_bid_DOM,
        input_bid_DOM, current_bid_DOM, current_bid_user_DOM, starting_price_DOM)

    if recent_activity_DOM.attr('placeholder') != placeholder_string
      recent_activity_DOM.effect( "explode", { times: 1 }, "slow", ->
      setTimeout (->
        recent_activity_DOM.removeAttr("style").hide().fadeIn()
        ), 500
      )
      recent_activity_DOM.attr( 'placeholder', placeholder_string)


    # check for the user and that balance is not currently displayed
    if user_id == parseFloat(current_user_DOM.val()) && balance != balance_placeholder_DOM
      balance_DOM.attr( 'placeholder', balance )

      # When money has gone, flash red
      if balance < balance_placeholder_DOM
        i = 0
        while i < 2
          balance_DOM.animate( { backgroundColor: '#CC3333' } ).fadeTo("slow", 0.5, ->
            $(this).removeAttr('style')
          ).fadeTo("slow", 1.0)
          i++

      # When receiving money, flash green
      if balance > balance_placeholder_DOM
        i = 0
        while i < 2
          balance_DOM.animate( { backgroundColor: '#009966' } ).fadeTo("slow", 0.5, ->
            $(this).removeAttr('style')
          ).fadeTo("slow", 1.0)
          i++
