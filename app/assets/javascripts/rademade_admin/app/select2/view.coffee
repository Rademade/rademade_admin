class @Select2Input.View extends Backbone.View

  initItem : () ->
    @$item = @$el.find(".select-wrapper input[type='hidden']")
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
      

  initSelect2 : () ->
    @$item.select2(
      multiple : @model.isMultiple()
      placeholder : 'Enter search phrase'
      allowClear : true
      initSelection : (element, callback) ->
        callback $.map element.val().split(','), (id) ->
          id : id, text : id
      ajax :
        url : @model.get('searchUrl')
        dataType : 'json'
        data : (term) -> { q : term }
        results : (data) -> { results : data }
    ).unbind('change').bind 'change', (e) =>
      @model.get('related').update e.added
    @_updateData()
    @model.get('related').on 'data-change', @_updateData

  _updateData : () =>
    @$item.select2 'val', @model.getData()

  @init : ($el) ->
    view = new this
      model : new Select2Input.Model
      el : $el
    view.initItem()
    view

  @initAll : (e, within) ->
    @constructor._models ||= {}
    $('.input-holder:has(.select-wrapper)', within).each (index, select) =>
      $select = $(select)
      relatedClass = $select.find('.select-wrapper').data('rel-class')
      @constructor._models[relatedClass] ||= Select2Input.View.init($select).model

  @onSubmit : (e, relatedClass, modelData) ->
    @constructor._models[relatedClass].get('related').update modelData.data

$ ->
  $(document)
    .on('ready page:load', Select2Input.View.initAll)
    .on('form-saved', Select2Input.View.onSubmit)