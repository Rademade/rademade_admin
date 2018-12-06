$(document).on 'ready page:load init-plugins', ->

  $('#forgot-password-form').on
    'ajax-submit-always': (e, data) ->
      if (data.status == 200)
        $(e.currentTarget).html(data.responseText)