class @Select2Input.View extends Backbone.View

  events :
    'click [data-new]' : 'addRelation'

  initItem : () ->
    @$item = @$el.find('.select-wrapper input[type="hidden"]')
    @initModel()
    @initRelated()
    @initSelect2()

  initModel : () ->
    @model.set
      searchUrl : @$item.data('searchUrl')
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
      placeholder : 'Enter search phrase'
      allowClear : true
      ajax :
        url : @model.get('searchUrl')
        dataType : 'json'
        data : (term) -> { q : term }
        results : (data) -> { results : data }
    ).unbind('change').bind 'change', (e) =>
      @model.get('related').update(e.added) if e.added
    @_updateData()
    @model.get('related').on 'data-change', @_updateData

  addRelation : (e) ->
    e.preventDefault()
    relatedModel = @_createRelatedModel $(e.currentTarget).data('new')
    FormPopup.Initializer.getInstance().showPopup relatedModel

  _createRelatedModel : (url) ->
    relatedModel = new Select2Input.RelatedModel
      edit_url : url
    relatedModel.on 'data-change', () =>
      @model.get('related').add relatedModel
      @_updateData()
    relatedModel

  _updateData : () =>
    relatedData = @model.getRelatedData()
    @$item.select2('data', relatedData)

  @init : ($el) ->
    view = new this
      model : new Select2Input.Model
      el : $el
    view.initItem()
    view

  @initAll : (within) ->
    $('.input-holder:has(.select-wrapper)', within).each (index, select) =>
      Select2Input.View.init $(select)

$ ->
  $(document).on 'ready page:load', () ->
    Select2Input.View.initAll()