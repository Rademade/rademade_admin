initUrlVisit = () ->
  $('[data-link-url]').click () ->
    Turbolinks.visit $(this).data('linkUrl')

$ ->
  $(document).on 'ready page:load', initUrlVisit