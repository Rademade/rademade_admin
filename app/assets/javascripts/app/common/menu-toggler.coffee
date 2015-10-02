initMenuToggle = () ->
  $('#menuToggler').on 'click', () ->
    $('#wrapper').toggleClass('opened-menu')

$ ->
  $(document).on 'ready page:load', initMenuToggle