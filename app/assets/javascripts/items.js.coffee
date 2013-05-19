$ ->
  source = new EventSource(document.URL + '/time_left')
  source.addEventListener 'time_left', (event) ->
    time = $.parseJSON(event.data).time
    $('#time').empty()
    $('#time').append(time)
    if $('#time').is ":contains('This Item Has Expired')"
      $('#item_bid').remove()
