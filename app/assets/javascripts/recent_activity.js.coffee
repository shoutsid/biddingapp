### Event Listeners
## bids
# id:       typeOf(String)
#           kindOf(User)
#           { id => '1' }
#
# amount:   typeOf(Float) 
#           kindOf(Bid.amount)
#           { amount => 2000.0 }
#
# item:     typeOf(String)
#           kindOf(Item.name)
#           { item => 'CPU' }
#
# user:     typeOf(string)
#           kindOf(User.name)
#           { user => 'James' }
#
#################################
$ ->
  event_source_recent_activity = new EventSource('/events/recent_activity')
  
  event_source_recent_activity.addEventListener 'bids', (event) ->
    item = $.parseJSON(event.data).item
    user = $.parseJSON(event.data).user
    amount = $.parseJSON(event.data).amount
    
    recent_activity_DOM = $('#recent_activity')
    recent_activity_DOM.effect( "explode", { times: 1 }, "slow", ->
            setTimeout (->
              recent_activity_DOM.removeAttr("style").hide().fadeIn()
            ), 500
        )
    recent_activity_DOM.attr( 'placeholder', 'Bid:' + amount + ', by ' + user + ', on ' + item)
