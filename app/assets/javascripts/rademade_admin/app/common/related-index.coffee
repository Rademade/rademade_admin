initSelect = ->
  $item = $('.select2-add-link')
  url = $item.data('relListUrl')

  $item.select2(
    multiple : false
    placeholder : 'Enter search phrase'

    initSelection : (element, callback) ->
      ids = element.val().replace(/\s*/g, '').split(',')
      $.getJSON(url, { search : { id : ids } } ).done (data) ->
        $item.select2('enable', true)
        callback(data[0])

    ajax :
      url : url
      dataType : 'json'
      data : (term) -> { q : term }
      results : (data) -> { results : data }
  ).on 'change', (e) ->
    sendNew(e.added.link_url)

sendNew = (linkUrl) ->
  $.ajax
    url : linkUrl
    type : 'POST'
    success : ->
      location.reload()

$ ->
  $(document)
    .on('ready page:load init-select', initSelect)