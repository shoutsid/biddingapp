$ ->
  event_source = new EventSource('/events/users_balance')
  
  event_source.addEventListener 'balance', (event) ->
    user = $.parseJSON(event.data).id
    balance = $.parseJSON(event.data).balance

    balance_DOM = $('#user_balance')
    user_DOM = $('#user_id')

    balance_DOM.attr( 'placeholder', balance ) if user == user_DOM.val()
