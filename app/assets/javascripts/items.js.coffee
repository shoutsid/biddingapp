$ ->
  $('.fancybox').fancybox()
  balance_DOM = $('#user_balance')
  balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
  input_bid_DOM = $('#input_bid_amount')

  $('#new_bid').submit ->
    if input_bid_DOM.val() > parseFloat($('#user_balance').attr( 'placeholder' ))
      $('#unable_to_bid').modal('show')
      balance_DOM.animate( { backgroundColor: '#CC3333' } )
