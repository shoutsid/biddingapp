$ ->
  source = new EventSource(document.URL + '/time_left')
  $('[id^=time_left]').each (index) ->
    element = this

    source.addEventListener ('time_left_' + index), (event) ->
      time = $.parseJSON(event.data).time

      $(element).empty()
      $(element).append(time)
      if $(element).is ":contains('This Item Has Expired')"
        $('#item_' + index).fadeTo('slow', 0.33)
        $('#item_bid_' + index).remove()
