class @Select2Input.RelatedCollectionView extends Backbone.View

  initialize : () ->
    @collection.on 'add', @appendRelatedView

  appendRelatedView : (model) =>
    view = new Select2Input.RelatedView
      model : model
    @$el.append view.render().$el

  initSort : (views) ->
    @$el.disableSelection()
    @$el.sortable
      stop : () =>
        $children = @$el.children()
        _.each views, (view) =>
          view.model.set 'position', $children.index(view.$el) + 1
        @collection.resort()

  @init : ($list) ->
    views = []
    collection = new Select2Input.RelatedCollection
    $list.find('li').each () ->
      relatedView = Select2Input.RelatedView.init $(this)
      views.push relatedView
      collection.add relatedView.model
    collectionView = new this
      collection : collection
      el : $list
    collectionView.initSort views
    collectionView