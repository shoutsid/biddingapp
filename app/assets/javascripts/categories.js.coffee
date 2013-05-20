$ ->
  source = new EventSource(document.URL + '/time_left')
  $('[id^=time_left]').each (index) ->
    element = this

    source.addEventListener ('time_left_' + index), (event) ->
      time = $.parseJSON(event.data).time

      $(element).empty()
      $(element).append(time)
      if $(element).is ":contains('This Item Has Expired')"
        $('#item_bid_' + index).remove()
        $('#item_' + index).fadeTo('slow', 0.33)
        $('#item_sold_' + index).empty()
        $('#item_sold_' + index).append('SOLD!')
        $('#item_sold_' + index).css({ 'margin-top': '80px', 'text-align': 'center', 'color': 'red', 'font-size': '56px' })
        $('#item_sold_' + index).fadeIn('slow', 0.33)
