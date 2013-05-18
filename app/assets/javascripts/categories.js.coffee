$ ->
  source = new EventSource(document.URL + '/time_left')
  $('[id^=time_left]').each (index) ->
    element = this
    source.addEventListener ('time_left_' + index), (event) ->
      time = $.parseJSON(event.data).time
      $(element).empty()
      $(element).append(time)
