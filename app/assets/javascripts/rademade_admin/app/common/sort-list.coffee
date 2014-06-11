
swapDirection = (sortDirection) ->
  if sortDirection == 'asc'
    sortDirection = 'desc'
  else
    sortDirection = 'asc'

getUrlParams = ->
  pl = /\+/g
  search = /([^&=]+)=?([^&]*)/g

  decode = (s) ->
    decodeURIComponent s.replace(pl, " ")

  query = window.location.search.substring(1)
  urlParams = {}
  urlParams[decode(match[1])] = decode(match[2])  while match = search.exec(query)

  urlParams

paramsToString = (params)->
  str = []
  for param of params
    str.push(param + '=' + params[param])
  str.join('&')

initSorting = ->
  params = getUrlParams()

  params['direction'] ?= 'asc'

  $('.sort-button').click ->
    params['direction'] = if $(@).data('column') == params['sort']
      swapDirection(params['direction'])
    else
      'asc'

    params['sort'] = $(@).data('column')
    params['page'] ?= '1'

    query_string = paramsToString(params)

    Turbolinks.visit(window.location.pathname+'?'+query_string)

$ ->

  $(document).on('ready page:load', initSorting)