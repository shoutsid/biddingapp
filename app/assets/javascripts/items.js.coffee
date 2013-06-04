$ ->
  $('.fancybox').fancybox()
  balance_DOM = $('#user_balance')
  balance_placeholder_DOM = balance_DOM.attr( 'placeholder' )
  input_bid_DOM = $('#input_bid_amount')
  starting_price_DOM = parseFloat($('#starting_price').html())

  if starting_price_DOM >= parseFloat(input_bid_DOM.val())
    input_bid_DOM.attr( 'placeholder', (starting_price_DOM + 1))
    input_bid_DOM.attr( 'min', (starting_price_DOM + 1))
    input_bid_DOM.val(starting_price_DOM + 1)
  $('#new_bid').submit ->
    if input_bid_DOM.val() > parseFloat($('#user_balance').attr( 'placeholder' ))
      $('#unable_to_bid').modal('show')
      balance_DOM.animate( { backgroundColor: '#CC3333' } )
