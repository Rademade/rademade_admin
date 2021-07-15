$(document).on 'ready page:load init-plugins', ->

  $('#reset-password-form').on
    'ajax-submit-done': (e) ->
      window.location.reload()
