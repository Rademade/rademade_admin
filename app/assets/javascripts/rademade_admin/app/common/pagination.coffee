initPerPageChange = () ->
  $('#perPageSelect').on 'change', () ->
    Turbolinks.visit @options[@selectedIndex].value

$ ->
  $(document).on 'ready page:load', initPerPageChange