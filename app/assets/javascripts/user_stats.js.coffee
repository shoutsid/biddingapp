$ ->
  url = window.location.href

  placement_direction = ->
    if url.search('items/') > 0
      'right'
    else
      'bottom'

  $('[id^=user_stats]').each (index) ->
    $(this).popover
      html: true
      placement: placement_direction
      trigger: 'hover'
