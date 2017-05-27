class @Select2Input.RelatedCollection extends Backbone.Collection

  comparator : 'position'

  initialize : () ->
    @on 'add', @addPosition
    @on 'relation-remove', @removeFromCollection

  addPosition : (model) ->
    model.set 'position', @length

  removeFromCollection : (model) =>
    @remove model
    @_triggerChange()

  setSortable : (sortable) ->
    @sortable = sortable

  setDeletable : (deletable) ->
    @deletable = deletable

  isSortable : () ->
    @sortable

  isDeletable : () ->
    @deletable

  resort : () ->
    @sort()
    @_triggerChange()

  update : (data) ->
    @add new Select2Input.RelatedModel(data), merge : true
    @_triggerChange()

  getData : () ->
    @map (model) -> model.getData()

  _triggerChange : () ->
    @trigger 'data-change'