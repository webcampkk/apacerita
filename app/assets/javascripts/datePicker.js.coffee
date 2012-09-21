$ ->
  $("body").on({
    focus: ->
      $(this).glDatePicker({
        showAlways: false
        allowOld: false
        selectedDate: new Date($(this).val())
        onChange: (target, newDate) ->
          dateParts = newDate.toDateString().split(" ")
          target.val(dateParts[2].replace(/^[0]+/g,"") + " " + dateParts[1] + " " + dateParts[3])
      })  
  }, ".datePicker")