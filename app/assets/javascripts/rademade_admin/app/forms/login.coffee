$(document).on 'ready page:load', ->

  $('#login-form').on
    'ajax-submit-done': -> window.location.href = '/rademade_admin'