sendSorted = (dataList) ->
  $.ajax
    type : 'PATCH'
    url : "#{window.location.pathname}/sort"
    data :
      sorted : dataList

initDnDSorting = ->
  $table = $('[data-sortable]')
  $tableRows = $table.children('tr')

  if isDnDSorting($table, $tableRows)
    minimum = $tableRows.first().data('position')
    $table.tableDnD
      dragHandle : '.draggable-btn'
      onDragClass : 'is-dragging'
      onDrop : ->
        resortedList = []
        $table.children('tr').each (index, item) ->
          $item = $(item)
          resortedList.push
            id : $item.data('id')
            position : index + minimum
        sendSorted resortedList
        return
    return

isDnDSorting = ($table, $tableRows) ->
  first = window.location.search.indexOf('sort') is -1
  second = $tableRows.length > 0
  third = $table.data('sortable')
  first and second and third

$ ->
  $(document).on 'ready page:load', initDnDSorting