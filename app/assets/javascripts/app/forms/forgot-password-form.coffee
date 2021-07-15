$(document).on 'ready page:load', ->

  $('#forgot-password-form').on
    'ajax-submit-done': (e, data) ->
      $(e.currentTarget).html(data.template)