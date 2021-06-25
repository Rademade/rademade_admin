initUrlVisit = () ->
  $('[data-link-url]').click () ->
    window.location.href = $(this).data('linkUrl')

$ ->
  $(document).on 'ready page:load init-plugins', initUrlVisit
