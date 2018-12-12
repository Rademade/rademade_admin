class @Select2Input.RelatedView extends Backbone.View

  tagName : 'li'

  className : 'select2-item'

  events :
    'click [data-edit]' : 'editRelation'
    'click [data-remove]' : 'removeRelation'
    'click [data-duplicate]' : 'duplicateRelation'

  initialize : () ->
    @model.on 'relation-remove', @remove, this
    @model.on 'change', @render, this

  editRelation : (e) ->
    e.preventDefault()
    Content.getInstance().renderModel @model, @$el.data('additional-url-options')

  removeRelation : (e) ->
    e.preventDefault()
    @model.relationRemove() if confirm I18n.t('rademade_admin.remove_confirm.model')
    false

  duplicateRelation : (e) ->
    e.preventDefault()
    @model.trigger 'duplicate', @model.id, @$el.data('additional-url-options')

  render : () ->
    @$el.html @_getHtml(@model.toJSON())
    @$el.addClass('is-draggable') if @isSortable()
    return this

  isSortable : () ->
    if @model.collection
      @model.collection.isSortable()
    else
      false

  isDeletable : () ->
    if @model.collection
      @model.collection.isDeletable()
    else
      false

  isDuplicatable : () ->
    if @model.collection
      @model.collection.isDuplicatable()
    else
      false

  _getHtml : (data) ->
    JST['app/templates/related-item'] _.extend
      isSortable : @isSortable()
      isDeletable : @isDeletable(),
      isDuplicatable : @isDuplicatable()
    , data

  @init : ($el) ->
    $edit = $el.find('[data-edit]')
    model = new Select2Input.RelatedModel
      id : $el.data('id')
      text : $edit.text()
      editurl : $edit.data('edit')
    new this
      el : $el
      model : model