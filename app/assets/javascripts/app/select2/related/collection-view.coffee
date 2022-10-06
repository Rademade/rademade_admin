class @Select2Input.RelatedCollectionView extends Backbone.View

  initialize : (options) ->
    @collection.on 'add', @appendRelatedView
    @_views = options.views

  appendRelatedView : (model) =>
    view = new Select2Input.RelatedView
      model : model
    @$el.append view.render().$el
    @_views.push view

  initSort : () ->
    @$el.disableSelection()
    if @collection.isSortable()
      @$el.sortable
        stop : () =>
          $children = @$el.children()
          _.each @_views, (view) =>
            view.model.set 'position', $children.index(view.$el) + 1
          @collection.resort()

  @init : ($list) ->
    views = []
    collection = new Select2Input.RelatedCollection
    collection.setSortable $list.data('sortable')
    collection.setDeletable $list.data('deletable')
    collection.setDuplicatable $list.data('duplicatable')

    $list.find('li').each () ->
      relatedView = Select2Input.RelatedView.init $(this)
      views.push relatedView
      collection.add relatedView.model
    collectionView = new this
      collection : collection
      el : $list
      views : views
    collectionView.initSort()
    collection.on 'duplicate', (modelId, additionalUrlOptions) ->
      collectionView.trigger 'duplicate', modelId, additionalUrlOptions
    collectionView