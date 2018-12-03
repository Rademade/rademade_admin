$(document).on 'ready page:load', ->

  $('#forgot-password-form').on
    'ajax-submit-done': (e) -> console.log(e)