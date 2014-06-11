minimum = 0

sendSorted = (dataList) ->
  $.ajax
    type: "PATCH"
    url: urlWithoutParams()
    data:
      sorted: dataList
      minimum: minimum


initDnDSorting = ->
  if isDnDSorting()
    setMinimum()
    $(".table-sortable").tableDnD 
      onDrop: (table, row) ->
        rows = $(table).children('tr')
        i = 0
        resortedList = []

        rows.each (index, item) ->
          resortedList[i] = [ $(item).data('id'), item.id ]
          i++
        sendSorted(resortedList)
        return
    return

urlWithoutParams = ->
  window.location.pathname + '/re_sort'

setMinimum = ->
 minimum = $('.table-sortable').children('tr')[0].id

isDnDSorting = ->
  first  = window.location.search.indexOf('sort') == -1
  second = $('.table-sortable').children('tr').length > 0
  third  = $('.table-sortable').data('position')

  first && second && third

$ ->
  $(document).on('ready page:load', initDnDSorting)
