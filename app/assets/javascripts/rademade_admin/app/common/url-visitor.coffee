initUrlVisit = () ->
  $('[data-url]').click () ->
    Turbolinks.visit $(this).data('url')

$ ->
  $(document).on 'ready page:load', initUrlVisit