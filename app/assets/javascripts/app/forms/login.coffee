$(document).on 'ready page:load', ->

  $('#login-form').on
    'ajax-submit-done': (event, data) ->
      if data.redirect_url
        window.location.href = data.redirect_url
      else
        window.location.reload()
