#currentClass = []
#
#initSelect = ->
#  $(".select-wrapper input[type='hidden']").each ->
#    initItem $(this)
#
#initItem = ($item) ->
#  searchUrl = $item.data('searchUrl')
#  isMultiple = $item.data('relMultiple')
#  $input = $item.closest('.input-holder')
#
#  $item.select2(
#    multiple : isMultiple
#    placeholder : 'Enter search phrase'
#    allowClear : true
#
#    initSelection : (element, callback) ->
#      callback $.map element.val().split(','), (id) ->
#        id : id, text : id
#
#    ajax :
#      url : searchUrl
#      dataType : 'json'
#      data : (term) -> { q : term }
#      results : (data) -> { results : data }
#
#  ).unbind('change').bind 'change', (e) ->
#    console.log e.added
#    $select = $(this)
#    $table = $select.siblings('.select2-items-list')
#    addTable($select) if $table.length is 0
#    $table.html('') unless isMultiple
#    addItem(e.added, $table)
#    hideTags()
#
#  if isMultiple
#    data = []
#    $input.find('.select2-items-list li').each () ->
#      data.push $(this).data('id')
#    $item.select2('val', data)
#  else
#    # todo
#
#addTable = ($item) ->
#  $parent = $item.parent()
#  $parent.children('.select2-items-list').remove()
#  $parent.append('<ul class="select2-items-list"></ul>')
#
#  $table = $parent.children('.select2-items-list')
#
#  $($item.select2('data')).each ->
#    addItem this, $table
#
#  $table.sortable
#    stop : ->
#      changeSelectValue($table, $item)
#
#  $table.disableSelection()
#
#addItem = (item, $table) ->
#  $table.append(
#    "<li data-id='#{item.id}'>
#      <span>#{item.text}</span>
#      <button data-edit='#{item.edit_url}'>Edit</button>
#      <button data-remove>Delete</button>
#    </li>"
#  )
#
#  $("li[data-id='#{item.id}'] [data-remove]").unbind('click').bind 'click', (e) ->
#    e.preventDefault()
#    removeItem($(e.currentTarget).closest('li'), $table) if confirm 'Вы действительно хотите удалить данную модель?'
#
#removeItem = ($li, $table) ->
#  $li.remove()
#  changeSelectValue $table, $table.siblings('.select-wrapper')
#
#changeSelectValue = ($table, $input) ->
#  itemsList = []
#
#  $table.children('li').each ->
#    itemsList.push id : $(this).data('id')
#
#  $input.select2('data', itemsList)
#  hideTags()
#
#getId = (data) ->
#  if data.data._id
#    return data.data._id.$oid
#  else
#    return data.data.id
#
#selectOnSubmit = (e, modelClassName, data) ->
#  dataId = getId(data)
#  $select = $(".select-wrapper [data-rel-class='#{modelClassName}']")
#  newData = []
#  if $select.data('relMultiple')
#    newData.push($select.val()) if $select.val()
#    newData.push(dataId)
#  else
#    newData = dataId
#  $select.select2('destroy')
#  $select.val(newData)
#  initItem($select)
#
#selectCurrent = (event, data) ->
#  currentClass.push(data)
#
#$ ->
#  $(document)
#    .on('ready page:load init-select', initSelect)
#    .on('form-saved', selectOnSubmit)