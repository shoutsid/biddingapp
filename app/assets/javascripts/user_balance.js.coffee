### Event Listeners
## balance
# id:       typeOf(String)
#           kindOf(User)
#           { id => '1' }
#
# balance:  typeOf(Float) 
#           kindOf(User.balance)
#           { balance => 2000.0 }
#
#################################
$ ->
  event_source = new EventSource('/events/users_balance')
  
  event_source.addEventListener 'balance', (event) ->
    user = $.parseJSON(event.data).id
    balance = $.parseJSON(event.data).balance

    balance_DOM = $('#user_balance')
    balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
    user_DOM = $('#user_id')

    # check for the user and that balance is not currently displayed
    if user == user_DOM.val() && balance != balance_placeholder_DOM
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
