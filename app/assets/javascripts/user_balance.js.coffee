$ ->
  event_source_user_balance = new EventSource('/events/users_balance')
  
  event_source_user_balance.addEventListener 'balance', (event) ->
    user = $.parseJSON(event.data).id
    balance = $.parseJSON(event.data).balance

    balance_DOM = $('#user_balance')
    balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
    user_DOM = $('#user_id')

    if user == user_DOM.val() && balance != balance_placeholder_DOM
      balance_DOM.attr( 'placeholder', balance )

      if balance < balance_placeholder_DOM
        i = 0
        while i < 3
          balance_DOM.animate( { backgroundColor: '#CC3333' } ).fadeTo("slow", 0.5, ->
            $(this).removeAttr('style')
          ).fadeTo("slow", 1.0)
          i++

      if balance > balance_placeholder_DOM
        i = 0
        while i < 3
          balance_DOM.animate( { backgroundColor: '#009966' } ).fadeTo("slow", 0.5, ->
            $(this).removeAttr('style')
          ).fadeTo("slow", 1.0)
          i++
