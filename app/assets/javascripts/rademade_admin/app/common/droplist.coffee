$ ->
  $('.js-link').click ->
    box = $(this).closest '.js-box'
    dropList = box.find '.js-droplist'
    box.toggleClass 'clicked'
    dropList.toggle()
    return
  return