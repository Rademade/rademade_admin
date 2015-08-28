class @Select2Input.View extends Backbone.View

  events :
    'click [data-edit-relation]' : 'editRelation'

  initItem : () ->
    @$item = @$el.find('.select-wrapper input[type="hidden"]')
    @initModel()
    @initRelated()
    @initSelect2()

  initModel : () ->
    @model.set
      searchUrl : @$item.data('searchUrl')
      newUrl : @$item.data('newUrl')
      multiple : @$item.data('relMultiple')

  initRelated : () ->
    if @model.isMultiple()
      collectionView = Select2Input.RelatedCollectionView.init @$el.find('.select2-items-list')
      @model.set 'related', collectionView.collection
    else
      relatedData = @$el.children('input[type="hidden"]').data()
      @model.set 'related', new Select2Input.RelatedModel relatedData

  initSelect2 : () ->
    @$item.select2(
      multiple : @model.isMultiple()
      placeholder : I18n.t('rademade_admin.relation.search')
      allowClear : true
      formatNoMatches : () ->
        I18n.t('select2.no_results')
      formatSelection : (data, $container) =>
        @_appendEditButton($container) unless @model.isMultiple()
        data.text
      ajax :
        url : @_getUrl()
        dataType : 'json'
        data : @_getData
        results : @_getResults
    ).unbind('change').bind 'change', @_onChange
    @_updateData()
    @model.get('related').on 'data-change', @_updateData
    @_appendAddButton()

  editRelation : (e) ->
    e.preventDefault()
    if @model.get('related').get('editurl')
      Content.getInstance().renderModel @model.get('related')

  _appendEditButton : ($container) ->
    $container.after '<span class="select2-edit"></span>'

  _appendAddButton : () ->
    $addPlaceholder = $ @_placeholderForAdd()
    $addPlaceholder.click () =>
      @$item.select2('close')
      Content.getInstance().renderModel @_createRelatedModel(@model.get('newUrl'))
    @$item.select2('container').find('.select2-drop').append $addPlaceholder

  _getUrl : () ->
    @model.get('searchUrl')

  _getData : (term) ->
    q : term

  _getResults : (data) ->
    results : data

  _onChange : (e) =>
    addedElement = e.added
    if addedElement
      @model.get('related').update(addedElement)
    else if e.removed
      @model.get('related').clear()

  _createRelatedModel : (url) ->
    relatedModel = @_relatedModel url
    relatedModel.on 'data-change', () =>
      @model.get('related').add(relatedModel) if @model.isMultiple()
      @_updateData()
    relatedModel

  _updateData : () =>
    relatedData = @model.getRelatedData()
    if @model.isMultiple() or not _.isEmpty(relatedData)
      @$item.select2('data', relatedData)

  _relatedModel : (url) ->
    if @model.isMultiple()
      relatedModel = new Select2Input.RelatedModel
    else
      relatedModel = @model.get('related')
    relatedModel.set 'editurl', url
    relatedModel

  _placeholderForAdd : () ->
    JST['rademade_admin/app/templates/select2-add']()

  @init : ($el) ->
    view = new this
      model : new Select2Input.Model
      el : $el
    view.initItem()
    view

  @initAll : () ->
    $('.input-holder:has(.select-wrapper)').each (index, select) =>
      $select = $(select)
      unless $select.data('initialized')
        @init $select
        $select.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'ready page:load init-plugins', Select2Input.View.initPlugin