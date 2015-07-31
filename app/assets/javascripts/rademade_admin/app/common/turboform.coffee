initTurboform = () ->
  $('form[data-turboform]').on 'submit', () ->
    separator = if @action.indexOf('?') is -1 then '?' else '&'
    Turbolinks.visit @action + separator + $(this).serialize()
    return false

$ ->
  $(document).on 'ready page:load init-plugins', initTurboform
