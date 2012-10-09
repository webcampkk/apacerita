$ ->
  $("body").on({
    click: ->
       id = $(@).attr("data-id")
       $("#event-" + id + " .event-short-description").hide()
       $("#event-" + id + " .event-full-description").show()
       return false
  }, "a.show-more")

  $("body").on({
    click: ->
       id = $(@).attr("data-id")
       $("#event-" + id + " .event-short-description").show()
       $("#event-" + id + " .event-full-description").hide()
       return false
  }, "a.show-less")

  $("[rel=tooltip]").tooltip()