class @Select2Input.View extends Backbone.View

  resultLimit = 20

  initItem : () ->
    @$item = @$el.find('[data-rel-multiple]')
    @initModel()
    @initRelated()
    @initSelect2()

  initModel : () ->
    @model.set
      searchUrl : @$item.data('searchUrl')
      newUrl : @$item.data('newUrl')
      multiple : @$item.data('relMultiple')
      editable : @$item.data('editable')
      disabled : @$item.data('disabled')
      destroyable : @$item.data('destroyable')

  initRelated : () ->
    if @model.isMultiple()
      collectionView = Select2Input.RelatedCollectionView.init @$el.find('.select2-items-list')
      collectionView.on 'duplicate', (modelId, additionalUrlOptions) =>
        options = _.extend({ duplicate_from: modelId }, additionalUrlOptions || {})
        Content.getInstance().renderModel @_createRelatedModel(@model.get('newUrl')), options
      @model.set 'related', collectionView.collection
    else
      relatedData = @$el.children('input[type="hidden"]').data()
      @model.set 'related', new Select2Input.RelatedModel relatedData

  initSelect2 : () ->
    @$item.select2(
      multiple : @model.isMultiple()
      placeholder : I18n.t('rademade_admin.relation.search')
      allowClear : @model.get('destroyable')
      formatNoMatches : () ->
        I18n.t('select2.no_results')
      formatSelection : (data, $container) =>
        @_appendEditButton($container)
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

  editRelation : () ->
    if @model.get('related').get('editurl')
      Content.getInstance().renderModel @model.get('related')

  _appendEditButton : ($container) ->
    if !(@model.isMultiple() or @initalized) and @model.get('editable')
      @initalized = yes
      @$edit = $ @_editButton()
      @$edit.on 'mousedown', () =>
        @editRelation()
        false
      $container.after @$edit

  _appendAddButton : () ->
    return unless @model.get('newUrl')
    $addPlaceholder = $ @_placeholderForAdd()
    $addPlaceholder.click () =>
      @$item.select2('close')
      Content.getInstance().renderModel @_createRelatedModel(@model.get('newUrl')), $addPlaceholder.data('additionalUrlOptions')
    @$item.select2('container').find('.select2-drop').append $addPlaceholder

  _getUrl : () ->
    @model.get('searchUrl')

  _getData : (term) ->
    q : term

  _getResults : (data) =>
    result = []
    index = 0
    chosen = @$item.select2('val')
    while result.length isnt resultLimit
      item = data[index++]
      break if item is undefined
      result.push(item) if chosen.indexOf(item.id) is -1
    results : result

  _onChange : (e) =>
    addedElement = e.added
    if addedElement
      @model.get('related').update(addedElement)
      @$edit.show() if @$edit
    else if e.removed
      @$item.val('')
      @model.get('related').clear()
      @$edit.hide() if @$edit

  _createRelatedModel : (url) ->
    relatedModel = @_relatedModel url
    relatedModel.on 'data-change', () =>
      @model.get('related').add(relatedModel) if @model.isMultiple()
      @_updateData()
    relatedModel

  _updateData : () =>
    $(document).trigger 'view-update'
    relatedData = @model.getRelatedData()
    if @model.isMultiple() or relatedData.id
      @$item.select2('data', relatedData)

  _relatedModel : (url) ->
    if @model.isMultiple()
      relatedModel = new Select2Input.RelatedModel
    else
      relatedModel = @model.get('related')
    relatedModel.set 'editurl', url
    relatedModel

  _placeholderForAdd : () ->
    JST['app/templates/select2/add']()

  _editButton : () ->
    JST['app/templates/select2/edit']()

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

  @setResultLimit : (limit) -> resultLimit = limit

$ ->
  $(document).on 'ready page:load init-plugins', Select2Input.View.initPlugin
