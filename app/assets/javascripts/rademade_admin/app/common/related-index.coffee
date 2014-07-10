getUrlParams = ->
  pl = /\+/g
  search = /([^&=]+)=?([^&]*)/g

  decode = (s) ->
    decodeURIComponent s.replace(pl, " ")

  query = window.location.search.substring(1)
  urlParams = {}
  urlParams[decode(match[1])] = decode(match[2]) while match = search.exec(query)

  urlParams


initSelect = ->
  $item = $('.select2-add-link')
  url = $item.data('relListUrl')

  $item.select2(
    multiple : false
    placeholder : 'Enter search phrase'

    initSelection : (element, callback) ->
      ids = element.val().replace(/\s*/g, '').split(',')
      $.getJSON(url, {search : {id : ids}}).done (data) ->
        data = if isMultiple then data else data[0]
        $item.select2('enable', true)
        callback(data)

    ajax :
      url : url
      dataType : 'json'
      data : (term) -> {q: term}
      results : (data) -> {results: data}
  ).on 'change', (e) ->
    sendNew(e.added)


sendNew = (added) ->
  $.ajax
    url : ajax_link(added.id)
    type : 'PUT'
    data : getUrlParams()
    success : ->
      location.reload()


ajax_link = (id) ->
  location.href.substring(0, location.href.indexOf(location.search)) + '/' + id + '/link_relation'


$ ->
  $(document)
    .on('ready page:load init-select', initSelect)